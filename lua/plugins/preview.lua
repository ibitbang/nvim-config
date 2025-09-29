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
    keys = {
      {
        "gpd",
        function()
          require("goto-preview").goto_preview_definition()
        end,
        desc = "Preview Definition",
      },
      {
        "gpt",
        function()
          require("goto-preview").goto_preview_type_definition()
        end,
        desc = "Preview Type Definition",
      },
      {
        "gpi",
        function()
          require("goto-preview").goto_preview_implementation()
        end,
        desc = "Preview Implementation",
      },
      {
        "gpD",
        function()
          require("goto-preview").goto_preview_declaration()
        end,
        desc = "Preview Declaration",
      },
      {
        "gpr",
        function()
          require("goto-preview").goto_preview_references()
        end,
        desc = "Preview References",
      },
      {
        "gP",
        function()
          require("goto-preview").close_all_win()
        end,
        desc = "Close All Previews",
      },
    },
  },
}
