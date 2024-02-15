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

return M
