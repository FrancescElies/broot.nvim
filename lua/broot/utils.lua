local M = {}

--- Writes temp config for broot
---@param conf_hjson_path string
M.write_select_hjson = function(conf_hjson_path)
  local file = assert(io.open(conf_hjson_path, "w"))
  local conf = [[
  verbs: [
    {
        invocation: "ok"
        key: "enter"
        leave_broot: true
        execution: ":print_path"
        apply_to: "file"
    }
  ]
]]
  file:write(conf)
  file:flush()
  file:close()
end

--- Trims a string
---@param s string
---@return string
local function trim(s)
  return s:match("^%s*(.*)"):match("(.-)%s*$")
end

--- When executing broot in a term the first line is reputed many times
--  and only contains the current folder where broot is executed.
---@param lines string[]
---@return string[]
M.clean_stdout = function(lines)
  out_lines = {}
  local first_line = trim(lines[1])
  for index, line in ipairs(lines) do
    if index > 1 then
      line = trim(line)
      if line ~= "" and line ~= first_line then
        table.insert(out_lines, line)
      end
    end
  end
  return out_lines
end

M.find_git_root = function()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end
return M
