if exists('g:loaded_nvim_typer') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" command to run our plugin
command! NvimTyper lua require'nvim-typer'.nvim_typer()

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_nvim_typer = 1
