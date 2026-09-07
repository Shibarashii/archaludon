return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- load before other plugins
	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false,
		term_colors = true,
		integrations = {
			blink_cmp = true,
			gitsigns = true,
			neotree = true,
			treesitter = true,
			telescope = true,
			which_key = true,
			mason = true,
		},
		-- Replaces the old integrations.native_lsp block (current catppuccin API)
		lsp_styles = {
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		-- This is the key part: catppuccin uses "mauve" as its default
		-- accent color across highlight groups (keywords, statusline
		-- highlights, cursor, etc). Overriding mauve -> green gives you
		-- a full "green accent" reskin without touching every highlight.
		-- color_overrides = {
		--  mocha = {
		--    mauve = "#a6e3a1", -- mocha's own "green" hex
		--  },
		-- },
	},
	config = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
