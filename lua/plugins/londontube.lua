return {
  {
    "londontube-light",
    dir = vim.fn.stdpath("config") .. "/lua/plugins",
    virtual = true,
    lazy = false,
    priority = 1000,
    config = function()
      -- Define the iconic London Tube Light hex codes
      local tube = {
        bg = "#FFF9E6",      -- Bright London Canvas Base
        fg = "#111111",      -- Northern Line text execution
        central = "#E32017", -- Red
        district = "#00782A",-- Green
        circle = "#C29F00",  -- Darkened Circle Line Yellow for legibility
        piccadilly = "#003688", -- Blue
        metropolitan = "#9B0056", -- Magenta/Purple
        waterloo = "#4A8271", -- Deepened Teal for contrast
        jubilee = "#A0A5A9",  -- Silver/Grey
        comment = "#666666",  -- Muted gray for readable text comments
      }

      -- Set Neovim to Light Mode environment
      vim.opt.background = "light"

      -- 1. Apply light-variant terminal registers
      vim.g.terminal_color_0  = tube.fg
      vim.g.terminal_color_1  = tube.central
      vim.g.terminal_color_2  = tube.district
      vim.g.terminal_color_3  = tube.circle
      vim.g.terminal_color_4  = tube.piccadilly
      vim.g.terminal_color_5  = tube.metropolitan
      vim.g.terminal_color_6  = tube.waterloo
      vim.g.terminal_color_7  = tube.jubilee
      vim.g.terminal_color_8  = tube.comment
      vim.g.terminal_color_9  = "#B1110E"
      vim.g.terminal_color_10 = "#00521D"
      vim.g.terminal_color_11 = "#917700"
      vim.g.terminal_color_12 = "#002154"
      vim.g.terminal_color_13 = "#68003A"
      vim.g.terminal_color_14 = "#335C4F"
      vim.g.terminal_color_15 = "#111111"

      -- 2. Build core Neovim UI Highlight Groups mapping to the light palette
      local highlights = {
        Normal = { fg = tube.fg, bg = tube.bg },
        NormalFloat = { fg = tube.fg, bg = "#F5EED7" }, -- Slightly darker tint for dropdowns
        Comment = { fg = tube.comment, italic = true },
        Constant = { fg = tube.waterloo },
        String = { fg = tube.district },
        Identifier = { fg = tube.piccadilly },
        Function = { fg = tube.metropolitan },
        Statement = { fg = tube.central, bold = true },
        PreProc = { fg = tube.central },
        Type = { fg = tube.piccadilly, bold = true },
        Special = { fg = tube.circle },
        LineNr = { fg = tube.jubilee, bg = tube.bg },
        CursorLineNr = { fg = tube.central, bold = true },
        Visual = { bg = "#E5DCBF" },                   -- Highlighted text blocks
        Pmenu = { fg = tube.fg, bg = "#F5EED7" },
        PmenuSel = { fg = tube.bg, bg = tube.piccadilly },
      }

      -- Dynamic batch allocation loop
      for group, opts in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end,
  },
}

