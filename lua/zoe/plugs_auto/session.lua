return {
  {
    'rmagatti/auto-session',
    enabled = true,
    lazy = false,
    config = function()
      require('auto-session').setup {
        enabled = true,
        log_level = 'error',
        suppressed_dirs = { 'node_modules', '.git', '~/Download', 'tmp' },
        session_lens = {
          load_on_setup = true,
          buftypes_to_ignore = { 'nofile', 'prompt' },
          theme_conf = {
            border = true,
            position = 'bottom',
            -- width = 80,
            -- height = 16,
          },
          previewer = false,
        },
        vim.keymap.set('n', '<leader>0s', '<cmd>SessionSave<CR> ', { noremap = true, desc = '[s]ave session' }),
        vim.keymap.set('n', '<leader>0r', '<cmd>SessionRestore<CR> ', { noremap = true, desc = 'session [r]estore' }),
        vim.keymap.set('n', '<leader>0\\', '<cmd>SessionSearch<CR> ', { noremap = true, desc = '[\\] search session' }),
        vim.keymap.set('n', '<leader>0p', '<cmd>SessionPurgeOrphaned<CR> ', { noremap = true, desc = 'session [p]urge orphaned' }),
        vim.keymap.set('n', '<leader>0d', '<cmd>Autosession delete<CR> ', { noremap = true, desc = 'session [d]elete' }),
      }
    end,
  },
}
