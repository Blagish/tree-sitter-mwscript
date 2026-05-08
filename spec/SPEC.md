# MWScript / TES Script — Language Specification

A consolidated parser-oriented specification of the Morrowind / TES Construction Set scripting language ("MWScript"), distilled from:

- [*Morrowind Scripting For Dummies*, 9th ed.](https://www.nexusmods.com/morrowind/mods/13969) (GhanBuriGhan, Yacoby, melian).
- [Project Tamriel Wiki errata](https://wiki.project-tamriel.com/wiki/Morrowind_Scripting_for_Dummies) (rev 3089, 20.10.2023).
- Empirical inspection of ~600 real `.mwscript` files from the game itself.

Two companion files contain the bulk reference data and are not duplicated here:

- `functions.md` — full catalog of built-in functions by category.
- `appendix-and-notes.md` — Tribunal/Bloodmoon additions, special globals, magic effects, console commands, GMSTs, parser pitfalls.

This spec is the source of truth for the tree-sitter grammar.

---

## 1. Overview

MWScript is an **interpreted, statement-oriented, line-based, case-insensitive** scripting language. Every script is a single `Begin … End` block. Scripts execute one full pass per game frame (top to bottom), restart on the next frame, and have no functions, no classes, no goto, and no first-class strings or object references.

Three control-flow constructs exist: `If/Elseif/Else/Endif`, `While/EndWhile`, and `Return`. Variable types are `short`, `long`, `float`. There are no booleans (`0` is false, anything else is true).

**Parser philosophy.** The CS compiler is permissive: optional commas, optional parentheses, lenient whitespace around `->`. The grammar should likewise be lenient — accept a superset and let the engine reject semantic errors.

---

## 2. Lexical structure

### 2.1 Source layout

- Files contain exactly one script: `Begin Name … End [Name]`.
- Statements are separated by **newline**. There is **no** statement separator other than newline; **no** line continuation (`\` at end of line is invalid).
- Indentation (tabs/spaces) is purely cosmetic.
- Files are typically Windows-1252; modern editors use UTF-8 (the engine accepts ASCII-clean scripts).

### 2.2 Whitespace and comments

- Whitespace = space `0x20`, tab `0x09`, CR `0x0D`, LF `0x0A`.
- Comments start with `;` and run to end-of-line. There is **no** block comment.
- A comment may follow code on the same line: `set foo to 1 ; my note`.
- The string scanner runs **before** the comment scanner: `"foo;bar"` is a single string, not a string + comment.

### 2.3 Identifiers

- Pattern: `[A-Za-z_][A-Za-z0-9_]*`.
- Case-**insensitive** for keywords, function names, and variable references.
- Object IDs may additionally contain hyphens and start with a digit, but **must be quoted** when they do (e.g. `"11NPC01"`, `"Sirollus Saccus"`).
- Cell IDs frequently contain spaces — always quoted: `"Ghostgate, Tower of Dusk"`.
- A bareword identifier and a quoted string occupy the same syntactic slot in argument lists (the compiler accepts either).
- `Player` is a magic identifier referring to the player character; it is reserved by convention.

#### Script names — separate token class

Script names (the identifier after `Begin`/`End`) are tokenized separately from regular identifiers so they may additionally contain **hyphens**: `BILL_TT_Bulfim_gra-Shugharz`, `Akula-doors`, etc. Real mods produce them.

```
ScriptName := [A-Za-z_][A-Za-z0-9_-]*
```

The hyphen is *not* added to the regular identifier rule, otherwise `a-b` (binary subtraction on two variables) would tokenize as a single identifier. Confining hyphens to the `Begin`/`End` slot keeps both forms unambiguous.

### 2.4 Keywords

Reserved words (case-insensitive) — these never appear as user identifiers:

```
Begin   End
If      Elseif      Else        Endif
While   EndWhile
Return
Set     to
short   long        float
```

Notes:
- `Elseif`, `Endif`, `EndWhile` are **single tokens**. `Else if`, `End if`, `End While` are not equivalent.
- `Begin` / `End` may or may not be followed by the script name (it's optional on `End`).
- `to` is part of the assignment statement (`Set lhs to rhs`); it is a keyword only in that position.

The MWEdit compiler additionally refuses these as variable names: single axis tokens `x`, `y`, `z` (any case). Treat as reserved in declarations only.

### 2.5 String literals

```
string := '"' [^"\n]* '"'
```

- Double-quoted; no escape sequences; cannot span lines; `"` cannot appear inside.
- Strings may contain interpolation tokens used by `MessageBox` / `Journal`:
  - **Text-defines** prefixed with `^`: `^PCName`, `^PCClass`, `^PCRace`, `^PCRank`, `^NextPCRank`, `^Cell`, `^Global`, `^Name`, `^Race`, `^Class`, `^Faction`, `^Rank`, `^Gamehour`. (Faction/Rank/PCRank/NextPCRank don't work in MessageBox per errata, but are still valid tokens.)
  - **Format specifiers** (printf-style): `%g`, `%G`, `%f`, `%.2f`, `%.0f`, `%S`. Following C `printf` semantics for `g`/`G`.
- A highlighter SHOULD colorize these markers as injections inside the string; parsing them is optional.

### 2.6 Numeric literals

```
integer := '-'? [0-9]+
float   := '-'? [0-9]+ '.' [0-9]+
```

- Floats **must** have a leading digit: `0.2` valid, `.2` invalid.
- No scientific notation in practice (the docs use `2.385901x10^9` as math notation, not source).
- Negative literals: a leading `-` is part of the literal in most contexts; in expressions it acts as unary minus. The grammar can model either way.

### 2.7 Operators and punctuation

| Category | Tokens |
|---|---|
| Arithmetic | `+`  `-`  `*`  `/` |
| Comparison | `==`  `=`  `!=`  `<`  `<=`  `>`  `>=` |
| Member call (target arrow) | `->` |
| Member access (variable) | `.` |
| Grouping | `(` `)` |
| Argument separator | `,` (optional — see §3.3) |

Notes:
- There are **no** boolean operators in real-world MWScript. The PDF and all 600+ example scripts confirm: `if (a AND b)` is invalid; nested `if` blocks are the workaround. Parsers should treat `AND`/`OR`/`NOT` as ordinary identifiers (they will be flagged at runtime if used).
- A single `=` is accepted by the engine as a comparison alias for `==` inside conditions (`if ( foo = 1 )`). This is technically a typo the engine tolerates; it is widespread in real mods. The grammar accepts both forms; semantic tooling MAY warn on `=`.
- `->` may have whitespace on either side (`"foo" -> Activate` is legal), but most code writes it tight (`"foo"->Activate`) to avoid edge-case CS bugs.
- `.` is reserved for cross-script variable access only: `objectID.varName` or `scriptID.varName`. It does **not** appear in number-like positions outside floats.
- `[` and `]` are **not** syntax — they appear in documentation only to mark optional arguments. A parser MUST NOT accept them in source.

---

## 3. Grammatical structure

### 3.1 Top-level

```
Script        := ScriptStart Statement* ScriptEnd StrayEnd*
ScriptStart   := 'Begin' ScriptName Newline
ScriptEnd     := 'End' ScriptName? Newline?
StrayEnd      := 'End' Newline?
```

- Exactly one `Begin … End` per file. No nesting.
- The trailing identifier on `End` (and on any stray `End`) is the `ScriptName` token from §2.3 — it allows hyphens.
- The trailing identifier on `End` is optional but, when present, should match `Begin`'s name (engine-checked, not parser-required).
- The grammar **tolerates one or more stray `End` keywords** between the closing `End` and end-of-file. Real-world mods sometimes have duplicated `End` markers from copy-paste accidents; the engine ignores them and so does this parser.

### 3.2 Statements

```
Statement := Declaration
           | Assignment
           | IfStatement
           | WhileStatement
           | ReturnStatement
           | CallStatement
           | Comment
```

Each statement occupies one line. Blank lines and standalone comments are allowed between any two statements.

#### 3.2.1 Declarations

```
Declaration := ('short' | 'long' | 'float') Identifier
```

- Local variables only; globals are declared in the Construction Set, not in source.
- A short with the same name as one of the engine-set "game variables" (`OnPCEquip`, `OnPCAdd`, `OnPCDrop`, `OnPCSoulGemUse`, `OnPCRepair`, `OnPCHitMe`, `PCSkipEquip`, `CellChanged`, `companion`, `minimumProfit` (float), `StayOutside`, `AllowWerewolfForceGreeting`, `Nolore`, `NoIdle`, `NoFlee`, `NoHello`) makes the engine populate that variable each frame. From the parser's perspective these are ordinary declarations.

#### 3.2.2 Assignment

```
Assignment := 'Set' Lvalue 'to' Expression
Lvalue     := Identifier
            | (Identifier | String) '.' Identifier   ; foreign-script variable
```

- Both `Set foo to 1` and `Set MyObject.varName to 1` are valid.
- The object on the LHS of a `.` may be either a bareword identifier or a quoted string. Real scripts commonly use the quoted form when the object ID contains spaces: `Set "Frelene Acques".doorLocked to 1`.
- The right-hand side is a full expression (see §3.4).

#### 3.2.3 If

```
IfStatement := 'If' Expression                   Newline
                 Statement*
               ('Elseif' Expression              Newline
                 Statement*)*
               ('Else'                           Newline
                 Statement*)?
               'Endif'                           Newline
```

- The MSFD PDF says parentheses around the condition are **required**, but the engine actually accepts bare conditions: `if foo == 1` parses just as well as `if ( foo == 1 )`. Real mods use both forms. The grammar accepts a free `Expression` here; the parenthesized form is just `parenthesized_expression` from §3.4 occupying that slot.
- Spaces around the parens (when present) are conventional (`if ( foo == 1 )`); most CS bugs are around stripped whitespace.

#### 3.2.4 While

```
WhileStatement := 'While' Expression            Newline
                    Statement*
                  'EndWhile'                    Newline
```

- Same parenthesization rule as `If` — parens around the condition are accepted but not required.
- The body is repeated within one frame until the condition becomes false. (Differs from `If`, which checks once per frame.)

#### 3.2.5 Return

```
ReturnStatement := 'Return'
```

- Stops execution of the current frame; the script restarts from the top next frame.
- Legal anywhere a statement is, including inside `if`/`while` blocks.

#### 3.2.6 Calls (function and target)

```
CallStatement := Call
Call          := Target? FunctionName ArgList?
Target        := (QuotedID | BarewordID | 'Player') '->'
FunctionName  := Identifier
ArgList       := Arg ((',' | Whitespace) Arg)*
Arg           := Primary                     ; not the full Expression!
Primary       := Number
              | SignedNumber
              | String
              | Identifier
              | MemberAccess
              | '(' Expression ')'
SignedNumber  := '-' Number
```

- A bare function call: `Disable`, `Return`, `MessageBox "Hello"`.
- A targeted call: `"Larienna Macrina"->Say "file.wav" "Subtitle"`.
- A self-targeting reference is allowed: `"selfID".var` parses identically to any dot-access.
- The target may be:
  - A quoted string (the conventional form for IDs with spaces or leading digits).
  - A bareword identifier.
  - The literal `Player`.
- `Activate, Player` is parsed but the engine silently discards the trailing argument — the grammar should still accept it.

##### Why `Arg` is a `Primary`, not a full `Expression`

Engine-wise, `Func a + b` is genuinely ambiguous: it could mean `Func((a+b))` or `(Func(a)) + b`. The CS engine resolves this by spaces — but tree-sitter does not see spaces. To stay deterministic, this grammar restricts arguments to *primaries*: a number, signed number, string, identifier, member-access, or a parenthesized expression. To pass a binary expression as an argument, wrap it in parens: `Func (a + b)`. Real mods overwhelmingly follow this convention already.

Unary minus on a *number* is folded into a `SignedNumber` primary so `Move z -50` (axis arg + negative-number arg) parses as two args rather than as `Move(z) - 50`. Unary minus on an *identifier* (`-myDay`) is **not** part of `SignedNumber` — that form would conflict with binary subtraction in expressions and almost never appears in real scripts as an argument anyway.

### 3.3 Argument separators

- Between arguments, the separator is `( ',' | Whitespace )+`.
- Both `Func a b c`, `Func a, b, c`, and `Func, a, b, c` are valid.
- Leading commas (`Func, a`) are accepted as a separator before the first argument.
- The grammar SHOULD model this as a flat token list rather than a strict comma-separated rule, because real scripts mix the styles freely.

### 3.4 Expressions

```
Expression    := CmpExpr
CmpExpr       := AddExpr (CmpOp AddExpr)?
AddExpr       := MulExpr (('+'|'-') MulExpr)*
MulExpr       := Unary   (('*'|'/') Unary)*
Unary         := '-' Expression
              | Primary
              | Call                       ; bareword `Foo` parses as Call(no args)
Primary       := Number
              | String
              | MemberAccess
              | '(' Expression ')'
MemberAccess  := (Identifier | String) '.' Identifier
CmpOp         := '==' | '=' | '!=' | '<' | '<=' | '>' | '>='
```

Notes:
- A function call may appear in expression position: `set total to ( Player->GetStrength ) + ( Player->GetEndurance )`. A bareword identifier (no arrow, no args) is also a call — semantically distinguishable as a variable read at runtime, but syntactically just `Call(function = identifier)`.
- More than ~10 operators in one `Set` statement triggers an engine bug; the grammar accepts any length.
- Comparison expressions return short (1 or 0) and may be used as the entire `If` condition.

##### Parser pragma — `Call` vs binary minus

Inside an expression context, after a bareword call's argument list, a lookahead of `-` is genuinely ambiguous: it could begin a new `SignedNumber` argument or be a binary subtraction operator at the enclosing expression level. The reference grammar declares this as a GLR conflict on the `call` rule and lets tree-sitter explore both interpretations. In practice the resolution that wins is the one where the surrounding rule can complete — for `if ( Day - myDay )`, `-` becomes binary subtraction because `myDay` is not a number and so cannot start a `SignedNumber`. For `Move z -50`, `-50` parses as `SignedNumber` because there is no enclosing binary expression demanding the `-`.

---

## 4. Built-in identifier categories

Tree-sitter highlights distinguish:

| Category | Source | Examples |
|---|---|---|
| **Keywords** | §2.4 | `If`, `Set`, `Begin`, `Return` |
| **Type keywords** | §2.4 | `short`, `long`, `float` |
| **Built-in functions** | `functions.md` | `GetJournalIndex`, `AIWander`, `MessageBox`, `PlaySound3D` |
| **Game variables (engine-set locals)** | `functions.md`, "Special game variables" | `OnActivate`, `OnPCEquip`, `OnDeath`, `MenuMode`, `CellChanged` |
| **Special globals** | `appendix-and-notes.md`, "Special globals" | `GameHour`, `Day`, `DaysPassed`, `Random100`, `PCRace`, `PCVampire` |
| **Magic effect IDs** | `appendix-and-notes.md`, "Magic effects" | `sEffectFireDamage`, `sEffectChameleon` |
| **Game settings (GMSTs)** | `appendix-and-notes.md`, "Game settings" | `fRepairMult`, `iMaxActivateDist` |
| **Console commands** | `appendix-and-notes.md`, "Console commands" | `COC`, `TGM`, `FixMe`, `ToggleAI` |
| **Magic identifier** | §2.3 | `Player` |

The grammar itself does not need to enumerate these — they are all syntactically `Identifier`. The highlight queries (`highlights.scm`) are responsible for disambiguating them by name match.

For runtime resolution rules:
- A bareword resolves first as a local variable, then as a global, then as a function.
- Console commands compile as functions in scripts; treat them as functions in highlights.

---

## 5. Parser-relevant edge cases

Each item below is something a tree-sitter grammar must correctly handle. See `appendix-and-notes.md` §"Pitfalls" for the full list.

| # | Edge case | Grammar response |
|---|---|---|
| 1 | Strings vs comments — `"foo;bar"` | Tokenize strings before comments. |
| 2 | `End` may be `End` or `End ScriptName` | Trailing identifier optional. |
| 3 | `Endif`, `Elseif`, `EndWhile` are single tokens | One terminal each, not two. |
| 4 | Comma is optional separator | `( COMMA \| WS )+` between args. |
| 5 | Parens around `If`/`While` condition optional | `if foo == 1` and `if ( foo == 1 )` both parse. |
| 6 | `->` may have whitespace around it | Single multi-char op, optional pad. |
| 7 | Bareword and quoted string in same arg slot | Allow both as `Arg`. |
| 8 | Quoted IDs may start with a digit | `string` token covers it. |
| 9 | Cell IDs with commas / spaces in quotes | `string` token, no inner parsing. |
| 10 | Function calls can appear as expressions | `Call` reachable from `Primary`. |
| 11 | Variable-arity functions (e.g. `AIWander` 3–13 args, `MessageBox` N choices) | `ArgList` is flat repetition. |
| 12 | `[reset]` is documentation, not source | Don't accept `[ ]` tokens. |
| 13 | `^Token` and `%g` inside strings are interpolations | Optional injection grammar inside `string`. |
| 14 | Float requires leading digit | Don't accept `.5`. |
| 15 | No line continuation, no semicolon-separated statements | Newline is hard terminator. |
| 16 | Case-insensitive keywords/idents | `i` flag on regex tokens, or alternation of cases. |
| 17 | `;` inside string is part of string | (See #1.) |
| 18 | `Player->Func` is an idiomatic target call | `Player` allowed as target. |
| 19 | `.` for cross-script variable, `->` for function call | Two distinct forms. |
| 20 | `Activate, Player` extra arg is silently ignored | Allow trailing arg on any call. |
| 21 | Script names may contain hyphens (`gra-Shugharz`) | Separate `ScriptName` token used only after `Begin`/`End`. |
| 22 | `=` accepted as comparison alias for `==` in conditions | Comparison op alternation includes `=`. |
| 23 | LHS of `Set X.Y to ...` may have a string in `X` slot | `MemberAccess` accepts `Identifier \| String` as object. |
| 24 | Stray `End` keywords after the closing `End` (mod typo) | Tolerated as no-op trailing tokens. |
| 25 | `Func arg1 arg2` with binary expr arg is ambiguous | `Arg` is `Primary`, not full `Expression`; users wrap in parens. |

---

## 6. Reference resolution (informative — not for parser)

A bareword `foo` in a non-target, non-LHS position resolves at runtime in this order:

1. Local variable declared in the current script.
2. Global short/long/float (declared in CS).
3. Built-in function.
4. Compilable console command.
5. Otherwise — eval error.

A `foo.bar` form:
- If `foo` is a defined script name → `bar` is a variable in that global script.
- Else → `foo` is interpreted as an object ID, and `bar` is a local variable on the script attached to that object.

These rules belong in a future LSP, not in the syntactic grammar.

---

## 7. Versions and dialects

- Original Morrowind 1.0–1.6.
- **Tribunal** (2002) added ~38 functions and lifted the literal-only restriction on `SetPos`/`SetAngle`. (See `appendix-and-notes.md` §"Tribunal additions".)
- **Bloodmoon** (2003) added ~12 functions including the werewolf set, plus new `ChangeWeather` enum values 8 (snow) and 9 (blizzard).
- **MCP (Morrowind Code Patch)** fixes runtime bugs but does not change the language.
- **MWSE** (Morrowind Script Extender) and **OpenMW** add their own functions; out of scope for this spec but the grammar accommodates them automatically since they are syntactically just more identifiers.
