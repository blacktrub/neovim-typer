# About project
This is a plugin which can help you to convert your JSON data to python typed dicts right in neovim

## Demo
Soon

## Before you go 
You need to install [the program](https://github.com/ikornaselur/dict-typer) for being able to transform your json to python types.
```
pip install dict-typer
```

## How to install the plugin
You can install it right from Github with your favorite plugin manager, e.g.
```
Plug 'blacktrub/neovim-typer'
```

## Hotkey
Add this to your init.lua
```
vim.api.nvim_set_keymap('v', '<C-s>t', '<Esc>:NvimTyper<cr>', { noremap = true, silent = true })
```
