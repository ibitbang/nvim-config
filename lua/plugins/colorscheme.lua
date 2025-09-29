return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	--  {
	-- 	"catppuccin/nvim",
	-- 	opts = function(_, opts)
	-- 		local module = require("catppuccin.groups.integrations.bufferline")
	-- 		if module then
	-- 			module.get = module.get_theme
	-- 		end
	-- 		return opts
	-- 	end,
	-- },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-latte",
    },
  }
}
