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
    local lines = vim.fn.systemlist(string.format('echo \'%s\' | dict-typer', str))
    return lines
end

local function read_current_buf()
    local lines = api.nvim_buf_get_lines(curbuf, 0, -1, true)
    return sub_lines(lines)
end

local function replace_cur_buf(lines)
    api.nvim_buf_set_lines(curbuf, 0, -1, true, lines)
end

local function nvim_typer()
    local json = read_current_buf()
    local out_lines = json_to_python_dict(json)
    replace_cur_buf(out_lines)
end

return {
  nvim_typer = nvim_typer,
}
