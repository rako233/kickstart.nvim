return {
  {
    'j-morano/buffer_manager.nvim',
    config = function()
      require('buffer_manager').setup {
        line_keys = '12345678',
        short_file_names = false,
        short_term_names = false,
        loop_nav = true,
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        format_function = nil,
        order_buffers = 'lastused',
        show_indicators = nil,
        highlight = 'Normal:BufferManagerBorder',
        win_extra_options = {
          winhighlight = 'Normal:BufferManagerNormal',
        },
      }

      vim.keymap.set({ 'n', 't' }, '<leader>=', function()
        local bmui = require 'buffer_manager.ui'
        bmui.toggle_quick_menu()
      end, { desc = 'Buffer Manager' })
    end,
  },
}
