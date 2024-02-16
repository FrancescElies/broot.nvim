local opts = {
  nargs = "*",
  complete = function(ArgLead, CmdLine, CursorPos)
    -- return completion candidates as a list-like table
    return {
      "-w",
      "--whale-spotting",
      "-s",
      "--sizes",
      "-h",
      "--hidden",
      "-i",
      "--git-ignored",
      "-f",
      "--only-folders",
      "-g",
      "--show-git-info",
    }
  end,
}

vim.api.nvim_create_user_command("Br", function(opts)
  require("broot").br(opts.args)
end, opts)

vim.api.nvim_create_user_command("BrRoot", function(opts)
  require("broot").br_root(opts.args)
end, opts)
