-- Good things shamelessly copied from https://github.com/kdheepak/lazygit.nvim

local broot_window = require("broot.window")
-- local project_root_dir = require("lazygit.utils").project_root_dir

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
---@param event integer
local function on_exit(job_id, code, event)
  if code ~= 0 then
    print("broot failed")
    vim.cmd("silent! :bdelete")
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
end

local function is_broot_available()
  return vim.fn.executable("broot") == 1
end

---@class CustomModule
local M = {}

M.launch_broot = function()
  if is_broot_available() ~= true then
    print("Please install broot 🐮 https://dystroy.org/broot/install")
    return
  end

  prev_win = vim.api.nvim_get_current_win()

  win, buffer = broot_window.open_floating()

  local cmd = "broot"
  if BROOT_LOADED == false then
    -- ensure that the buffer is closed on exit
    vim.g.broot_opened = 1
    vim.fn.termopen(cmd, { on_exit = on_exit })
  end
  vim.cmd("startinsert") -- insert mode
end

return M
