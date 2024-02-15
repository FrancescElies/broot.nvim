# Broot in nvim

<!-- ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/ellisonleao/nvim-plugin-template/lint-test.yml?branch=main&style=for-the-badge) -->
<!-- ![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua) -->

Integrates (broot)[https://dystroy.org/broot] into nvim

## Install
Install using lazy.nvim:

```lua
require("lazy").setup({
    {
        "FrancescElies/broot.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
})
```
# Test it
Quick test `nvim -c "Broot"`

<!--
## Features and structure 

- 100% Lua
- Github actions for:
  - running tests using [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) and [busted](https://olivinelabs.com/busted/)
  - check for formatting errors (Stylua)
  - vimdocs autogeneration from README.md file
  - luarocks release (LUAROCKS_API_KEY secret configuration required)
-->
