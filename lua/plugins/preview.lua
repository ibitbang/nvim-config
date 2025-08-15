return {
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
    },
  },
  {
    "rmagatti/logger.nvim",
    enabled = true,
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    opts = {
      event = "BufEnter",
      config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },
  },
}
