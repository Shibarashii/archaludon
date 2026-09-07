return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require('telescope').setup({
        extensions = {
          -- ui-select replaces the default vim.ui.select with a telescope picker
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })

      -- Load extensions after setup
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')

      -- Keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files,  { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep,   { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers,     { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags,   { desc = 'Telescope help tags' })
    end,
  },
}
