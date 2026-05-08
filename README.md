# tree-sitter-mwscript

[Tree-sitter](https://tree-sitter.github.io) grammar for **MWScript** — the scripting language of *The Elder Scrolls III: Morrowind* (TES Construction Set).

## Features

- Full statement coverage: `Begin/End`, declarations, `Set/To`, `If/Elseif/Else/Endif`, `While/EndWhile`, `Return`
- Targeted calls: `"Object"->Function args`, `Object->Function args`
- Cross-script member access: `OtherScript.variable`
- Case-insensitive keywords
- Optional parentheses in conditions
- `=` as comparison alias (engine quirk, common in real scripts)
- Tolerates stray duplicate `End` markers found in some mod files

## Editor support

### Neovim (nvim-treesitter)

```lua
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.mwscript = {
  install_info = {
    url = "https://github.com/Blagish/tree-sitter-mwscript",
    files = { "src/parser.c" },
  },
  filetype = "mwscript",
}
```

Add to your filetype detection (e.g. `~/.config/nvim/ftdetect/mwscript.vim`):

```vim
au BufRead,BufNewFile *.mwscript set filetype=mwscript
```

### Helix

Add to `~/.config/helix/languages.toml`:

```toml
[[language]]
name = "mwscript"
scope = "source.mwscript"
file-types = ["mwscript"]
comment-tokens = ";"
grammar = "mwscript"

[[grammar]]
name = "mwscript"
source = { git = "https://github.com/Blagish/tree-sitter-mwscript", rev = "<commit>" }
```

### Zed

*there will be a link soon*

### Emacs (treesit, 29+)

```elisp
(add-to-list 'treesit-language-source-alist
             '(mwscript "https://github.com/Blagish/tree-sitter-mwscript"))
(treesit-install-language-grammar 'mwscript)
```

## Development

```bash
npm install
npm run generate       # regenerate parser after editing grammar.js

# parse a single file
npx tree-sitter parse path/to/script.mwscript

# run against a corpus and report success rate
npx tree-sitter parse --quiet --stat corpus/*.mwscript | tail -3

# preview highlights in the terminal
npx tree-sitter highlight path/to/script.mwscript
```

## Node bindings

```js
const Parser = require("tree-sitter");
const MWScript = require("tree-sitter-mwscript");

const parser = new Parser();
parser.setLanguage(MWScript);

const tree = parser.parse(`
Begin MyScript
  short myVar
  Set myVar to 42
End
`);
console.log(tree.rootNode.toString());
```

## License

MIT
