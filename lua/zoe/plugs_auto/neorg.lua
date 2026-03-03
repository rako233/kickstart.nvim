return {
  {
    'nvim-neorg/neorg',
    enabled = false,
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      local wk = require 'which-key'
      wk.add { { '<leader>n', group = '[n]eorg' } }
      require('neorg').setup {
        vim.keymap.set('n', '<leader>nn', '<Plug>(neorg.dirman.new-note)', { buffer = true, desc = '[n]ew note' }),
        vim.api.nvim_create_autocmd('Filetype', {
          pattern = 'norg',
          callback = function()
            vim.keymap.set('i', 'C-\\p', '<Plug>(neorg.promo.Promote)', { buffer = true, desc = '[p]romote' })
            vim.keymap.set('i', 'C-\\d', '<Plug>(neorg.promo.demote)', { buffer = true, desc = '[d]emote' })
            vim.keymap.set('i', 'C-\\D', '<Plug>(neorg.tempus.insert-date.insert-mode)', { buffer = true, desc = 'Insert [D]ate' })
            vim.keymap.set('i', 'C-\\i', '<Plug>(neorg.itero.next-iteration)', { buffer = true, desc = 'Next [i]tera' })
            vim.keymap.set('n', '<leader>ntu', '<Plug>(neorg.qol.todo-items.todo.task-undone)', { buffer = true, desc = 'task undone' })
            vim.keymap.set('n', '<leader>ntp', '<Plug>(neorg.qol.todo-items.todo.task-pending)', { buffer = true, desc = 'task pending' })
            vim.keymap.set('n', '<leader>ntd', '<Plug>(neorg.qol.todo-items.todo.task-done)', { buffer = true, desc = 'task done' })
            vim.keymap.set('n', '<leader>nth', '<Plug>(neorg.qol.todo-items.todo.task-on-hold)', { buffer = true, desc = 'task on hold' })
            vim.keymap.set('n', '<leader>ntr', '<Plug>(neorg.qol.todo-items.todo.task-recurring)', { buffer = true, desc = 'task recurring' })
            vim.keymap.set('n', '<leader>nti', '<Plug>(neorg.qol.todo-items.todo.task-important)', { buffer = true, desc = 'task important' })
            vim.keymap.set('n', '<leader>nta', '<Plug>(neorg.qol.todo-items.todo.task-ambiguous)', { buffer = true, desc = 'task ambiguous' })
            vim.keymap.set('n', '<leader>ntc', '<Plug>(neorg.qol.todo-items.todo.task-cancelled)', { buffer = true, desc = 'task cancel' })
            vim.keymap.set('n', '<leader>nj', '<Plug>(neorg.esupports.hop.hop-link)', { buffer = true, desc = 'jump to link' })
            vim.keymap.set('n', '<leader>njt', '<Plug>(neorg.esupports.hop.hop-link.tab-drop)', { buffer = true, desc = 'jump to link in new tab' })
          end,
        }),
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = {},
          ['core.keybinds'] = {
            config = {
              default_keybinds = false,
            },
          },
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/notes',
              },
              default_workspace = 'notes',
            },
          },
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
