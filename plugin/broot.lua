vim.api.nvim_create_user_command("Br", require("broot").br, {})
vim.api.nvim_create_user_command("BrRoot", require("broot").br_root, {})
