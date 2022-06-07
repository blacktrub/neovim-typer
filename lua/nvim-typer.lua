
local api = vim.api
local curbuf = 0

local function get_last_command_result()
    return vim.v.shell_error
end

local function is_typer_installed()
    vim.fn.systemlist("dict-typer --version")
    return get_last_command_result() == 0
end

local function show_error(text)
    print("NvimTyper:", text)
end

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
    if get_last_command_result() ~= 0 then
        show_error("Json decoding error")
        return
    end

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
    if not is_typer_installed() then
        show_error("You need to install dict-typer: pip install dict-typer")
        return
    end

    local start_block, _ = unpack(api.nvim_buf_get_mark(curbuf, '<'))
    local end_block, _ = unpack(api.nvim_buf_get_mark(curbuf, '>'))
    local json = read_current_buf(start_block - 1, end_block)
    local out_lines = json_to_python_dict(json)
    if not out_lines then
        return
    end
    replace_cur_buf(start_block - 1, end_block, out_lines)
end

return {
  nvim_typer = nvim_typer,
}
