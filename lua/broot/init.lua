-- Good things shamelessly copied from https://github.com/kdheepak/lazygit.nvim
-- Bad parts probably mine

local broot_window = require("broot.window")
local broot_utils = require("broot.utils")

local conf_hjson_path = vim.fn.tempname() .. ".hjson"

broot_utils.write_select_hjson(conf_hjson_path)

BROOT_BUFFER = nil
BROOT_LOADED = false
vim.g.broot_opened = 0
local prev_win = -1
local win = -1
local buffer = -1

--- on_exit callback function to delete the open buffer when lazygit exits in a neovim terminal
---
---@param job_id integer
---@param code integer
---@param event string
local function on_exit(job_id, code, event)
  local current_buf = 0
  local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)

  lines = broot_utils.clean_stdout(lines)

  if code ~= 0 then
    print("broot failed")
    vim.cmd("silent! :checktime")
    return
  end

  BROOT_BUFFER = nil
  BROOT_LOADED = false
  vim.g.broot_opened = 0
  vim.cmd("silent! :checktime")

  if vim.api.nvim_win_is_valid(prev_win) then
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_set_current_win(prev_win)
    prev_win = -1
    if vim.api.nvim_buf_is_valid(buffer) and vim.api.nvim_buf_is_loaded(buffer) then
      vim.api.nvim_buf_delete(buffer, { force = true })
    end
    buffer = -1
    win = -1
  end

  -- open selected files in broot
  for _, line in ipairs(lines) do
    vim.api.nvim_command("edit " .. line)
  end
end

local function is_broot_available()
  return vim.fn.executable("broot") == 1
end

local M = {}

local function broot(cwd)
  if not is_broot_available() then
    print("Please install broot 🐮 https://dystroy.org/broot/install")
    return
  end

  prev_win = vim.api.nvim_get_current_win()

  win, buffer = broot_window.open_floating()

  local cmd = "broot --conf " .. conf_hjson_path .. " " .. cwd
  if BROOT_LOADED == false then
    -- ensure that the buffer is closed on exit
    vim.g.broot_opened = 1
    vim.fn.termopen(cmd, { on_exit = on_exit })
  end
  vim.cmd("startinsert") -- insert mode
end                      --- Starts broot
---@param cwd string

--- Executes broot on current buffer's folder
M.br = function()
  broot(vim.fn.expand("%:p:h"))
end

--- Executes broot at the git root repository
M.br_root = function()
  broot(".")
end

return M
