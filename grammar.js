/**
 * @file Tree-sitter grammar for MWScript (TES Construction Set scripting language).
 * @license MIT
 *
 * See spec/SPEC.md for the language specification.
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

/** Build a case-insensitive keyword token aliased to its lowercase literal,
 *  so highlight queries can match it as `"begin"` etc. regardless of source casing.
 *  No `prec` — we rely on tree-sitter's longest-match rule (e.g. `SetFight`
 *  beats `Set`) plus grammar context for disambiguation.
 */
function kw(word) {
  const pattern = word
    .split('')
    .map((c) => (/[a-zA-Z]/.test(c) ? `[${c.toLowerCase()}${c.toUpperCase()}]` : c))
    .join('');
  return alias(token(new RegExp(pattern)), word);
}

const PREC = {
  unary: 7,
  multiplicative: 6,
  additive: 5,
  comparison: 4,
};

module.exports = grammar({
  name: 'mwscript',

  // Whitespace and comments are skippable anywhere; newlines are NOT extras.
  extras: ($) => [/[ \t]+/, /\r/, $.comment],

  conflicts: ($) => [
    // After `Func`, lookahead `-` could mean:
    //   - extend args with `-N` (signed_number) → call(Func, args=[-N])
    //   - reduce call and treat `-` as binary subtraction → binary(Func, -, ...)
    // GLR explores both; precedence-based disambiguation is below.
    [$.call],
  ],

  rules: {
    source_file: ($) =>
      seq(repeat($._newline), optional($.script)),

    // Tolerate stray `End` keywords or blank lines after the script footer.
    // Real-world mods occasionally have duplicated `End` markers.
    _stray_end: ($) => kw('end'),

    script: ($) =>
      seq(
        $.script_header,
        repeat($._line),
        $.script_footer,
        repeat(choice($._newline, $._stray_end)),
      ),

    script_header: ($) =>
      seq(kw('begin'), field('name', $.script_name), $._newline),

    script_footer: ($) =>
      seq(kw('end'), optional(field('name', $.script_name))),

    // Script names allow hyphens (e.g. `BILL_TT_Bulfim_gra-Shugharz`).
    // Distinct from regular identifiers so `a-b` in expressions still tokenizes
    // as binary subtraction rather than one identifier.
    script_name: ($) => /[A-Za-z_][A-Za-z0-9_-]*/,

    _line: ($) => choice($._newline, seq($._statement, $._newline)),

    _statement: ($) =>
      choice(
        $.declaration,
        $.assignment,
        $.if_statement,
        $.while_statement,
        $.return_statement,
        $.call,
      ),

    // ---- Declarations ----------------------------------------------------

    declaration: ($) =>
      seq(field('type', $.type), field('name', $.identifier)),

    type: ($) => choice(kw('short'), kw('long'), kw('float')),

    // ---- Assignment ------------------------------------------------------

    assignment: ($) =>
      seq(
        kw('set'),
        field('lhs', $._lvalue),
        kw('to'),
        field('rhs', $._expression),
      ),

    _lvalue: ($) => choice($.identifier, $.member_access),

    member_access: ($) =>
      seq(
        field('object', choice($.identifier, $.string)),
        '.',
        field('member', $.identifier),
      ),

    // ---- If / While / Return --------------------------------------------

    // Conditions are typically parenthesized but the engine accepts bare
    // expressions too (`if foo == 1` without outer parens). Both forms parse
    // here since `parenthesized_expression` is already inside `_expression`.
    if_statement: ($) =>
      seq(
        kw('if'),
        field('condition', $._expression),
        $._newline,
        repeat($._line),
        repeat($.elseif_clause),
        optional($.else_clause),
        kw('endif'),
      ),

    elseif_clause: ($) =>
      seq(
        kw('elseif'),
        field('condition', $._expression),
        $._newline,
        repeat($._line),
      ),

    else_clause: ($) => seq(kw('else'), $._newline, repeat($._line)),

    while_statement: ($) =>
      seq(
        kw('while'),
        field('condition', $._expression),
        $._newline,
        repeat($._line),
        kw('endwhile'),
      ),

    return_statement: ($) => kw('return'),

    // ---- Calls -----------------------------------------------------------

    call: ($) =>
      seq(
        optional(seq(field('target', $._target), '->')),
        field('function', $.identifier),
        optional(field('arguments', $.argument_list)),
      ),

    _target: ($) => choice($.string, $.identifier),

    argument_list: ($) => prec.right(repeat1(seq(optional(','), $._argument))),

    // An argument is a tight primary — never a top-level binary expression.
    // Parentheses are required to pass a binary expression as an argument.
    _argument: ($) =>
      choice(
        $.number,
        $.signed_number,
        $.string,
        $.member_access,
        $.identifier,
        $.parenthesized_expression,
      ),

    signed_number: ($) => seq('-', $.number),

    // ---- Expressions -----------------------------------------------------

    _expression: ($) =>
      choice(
        $.number,
        $.string,
        $.member_access,
        $.unary_expression,
        $.binary_expression,
        $.parenthesized_expression,
        $.call,
      ),

    unary_expression: ($) =>
      prec(PREC.unary, seq(field('op', '-'), field('operand', $._expression))),

    binary_expression: ($) =>
      choice(
        prec.left(
          PREC.multiplicative,
          seq(
            field('left', $._expression),
            field('op', choice('*', '/')),
            field('right', $._expression),
          ),
        ),
        prec.left(
          PREC.additive,
          seq(
            field('left', $._expression),
            field('op', choice('+', '-')),
            field('right', $._expression),
          ),
        ),
        prec.left(
          PREC.comparison,
          seq(
            field('left', $._expression),
            // `=` is accepted by the engine as a comparison alias inside conditions
            // (legacy quirk; many real scripts have `if ( foo = 1 )`). Tokenize it
            // as a comparison operator alongside the canonical `==`.
            field('op', choice('==', '=', '!=', '<', '<=', '>', '>=')),
            field('right', $._expression),
          ),
        ),
      ),

    parenthesized_expression: ($) => seq('(', $._expression, ')'),

    // ---- Tokens ----------------------------------------------------------

    string: ($) => /"[^"\n]*"/,

    number: ($) => /[0-9]+(\.[0-9]+)?/,

    identifier: ($) => /[A-Za-z_][A-Za-z0-9_]*/,

    comment: ($) => /;[^\r\n]*/,

    _newline: ($) => /\r?\n/,
  },
});
