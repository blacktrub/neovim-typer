-- TODO: read later
-- https://github.com/clojure-vim/acid.nvim/blob/0236dbf67585816ca7350a87d3dcdda2c063e6d3/lua/acid/forms.lua#L45

local api = vim.api
local curbuf = 0

local function sub_lines(lines)
    local content = ""
    for _, value in pairs(lines) do
        content = content .. value
    end
    return content
end

local function json_to_python_dict(str)
    -- TODO: check errors
    local lines = vim.fn.systemlist(string.format('echo \'%s\' | dict-typer --no-imports', str))
    return lines
end

local function read_current_buf(s, e)
    local lines = api.nvim_buf_get_lines(curbuf, s, e, true)
    return sub_lines(lines)
end

local function replace_cur_buf(s, e, lines)
    api.nvim_buf_set_lines(curbuf, s, e, true, lines)
end

local function nvim_typer()
    local start_block, _ = unpack(api.nvim_buf_get_mark(curbuf, '<'))
    local end_block, _ = unpack(api.nvim_buf_get_mark(curbuf, '>'))
    local json = read_current_buf(start_block - 1, end_block)
    local out_lines = json_to_python_dict(json)
    replace_cur_buf(start_block - 1, end_block, out_lines)
end

return {
  nvim_typer = nvim_typer,
}
