return {
  -- change trouble config
  {
    "folke/snacks.nvim",
    -- opts will be merged with the parent spec
    opts = {
      image = { enabled = true },
      picker = {
        hidden = true,
        ignored = true,
      },
    },
  },
}
