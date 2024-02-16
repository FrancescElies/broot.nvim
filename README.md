# Broot in nvim

<!-- ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/ellisonleao/nvim-plugin-template/lint-test.yml?branch=main&style=for-the-badge) -->
<!-- ![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua) -->

[Telescope](https://github.com/nvim-telescope/telescope.nvim) is great but sometimes for certain jobs you already know other tools that fit better the job at hand, one of those is [broot](https://dystroy.org/broot). 

In certain situations you don't want to have to open another terminal just to use broot, 
this plugin aims to integrate broot into nvim to avoid that overhead.

## Install
Install using lazy.nvim:

```lua
require("lazy").setup({
  "FrancescElies/broot.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.keymap.set('n', '<C-p>', ':BrRoot<cr>', { desc = 'broot (git root)' })
    vim.keymap.set('n', '<leader>fb', ':Br<cr>', { desc = 'broot (current dir)' })
  end,
})
```

# Test it
Quick test `nvim -c "Br"`

<!--
## Features and structure 

- 100% Lua
- Github actions for:
  - running tests using [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) and [busted](https://olivinelabs.com/busted/)
  - check for formatting errors (Stylua)
  - vimdocs autogeneration from README.md file
  - luarocks release (LUAROCKS_API_KEY secret configuration required)
-->
