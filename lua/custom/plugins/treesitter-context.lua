return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    -- cmd = { 'TSContextEnable', 'TSContextDisable', 'TSContextToggle' },
    config = function()
      local wk = require 'which-key'
      wk.add { { '<leader>cc', group = '[C]ontext' } }
      require('treesitter-context').setup {
        enable = true,
        multiwindow = false, -- Enable multiwindow support.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = '🭹', -- nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        vim.keymap.set('n', '<leader>ccc', '<Cmd>TSContextToggle<CR>', { noremap = true, desc = 'Context Toggle' }),
      }
    end,
  },
}
