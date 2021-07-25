--
-- treesitter.lua
--

require("nvim-treesitter.configs").setup({
  ensure_installed = { "bash", "lua", "python" },
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = true },
})
