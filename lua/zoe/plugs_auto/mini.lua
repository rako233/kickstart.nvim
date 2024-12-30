return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      local combine_groups = function(groups)
        local parts = vim.tbl_map(function(s)
          if type(s) == 'string' then
            return s
          end
          if type(s) ~= 'table' then
            return ''
          end

          local string_arr = vim.tbl_filter(function(x)
            return type(x) == 'string' and x ~= ''
          end, s.strings or {})
          local str = table.concat(string_arr, ' ')

          -- Use previous highlight group
          if s.hl == nil then
            return ' ' .. str .. ' '
          end

          -- Allow using this highlight group later
          if str:len() == 0 then
            return '%#' .. s.hl .. '#'
          end

          return string.format('%%#%s#%s', s.hl, str)
        end, groups)

        return table.concat(parts, '')
      end

      -- This function takes 2 hl classes and creates a new hl class
      --@param hl_fg string : The highlight name of the highlight class
      --@param hl_bg string : The highlight name of another highlight class
      local make_color = function(hl_fg, hl_bg)
        ---@class vim.api.keyset.highlight
        ---@diagnostic disable-next-line: assign-type-mismatch
        local fghl = vim.api.nvim_get_hl(0, { name = hl_fg })
        local bghl = vim.api.nvim_get_hl(0, { name = hl_bg })
        fghl.fg = fghl.bg
        fghl.bg = bghl.bg
        vim.api.nvim_set_hl(0, hl_fg .. '2', fghl)
      end

      local mode_hl = {}
      local mode = ''

      local setup_hl = function()
        _, mode_hl = MiniStatusline.section_mode { trunc_width = 50 }
        make_color(mode_hl, 'MiniStatuslineFilename')
        make_color('MiniStatuslineDevinfo', 'MiniStatuslineFilename')
        make_color('MiniStatuslineFileInfo', 'MiniStatuslineFilename')
      end

      local modify_mode_group_hl = function()
        _, mode_hl = MiniStatusline.section_mode { trunc_width = 50 }
        make_color(mode_hl, 'MiniStatuslineFilename')
      end

      vim.api.nvim_create_autocmd('VimEnter', { pattern = '*', desc = 'add more hl groups', callback = setup_hl })
      vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*', desc = 'update hl group for mode', callback = modify_mode_group_hl })

      local statusline = require 'mini.statusline'

      statusline.setup {
        content = {
          -- Content for active window
          active = function()
            mode, mode_hl = MiniStatusline.section_mode { trunc_width = 50 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 50 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 80 }
            local lsp = MiniStatusline.section_lsp { trunc_width = 40 }
            local filename = MiniStatusline.section_filename { trunc_width = 80 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 50 }
            -- local location = MiniStatusline.section_location { trunc_width = 50 }
            local search = MiniStatusline.section_searchcount { trunc_width = 50 }

            local tab = {
              { hl = mode_hl, strings = { mode } },
              { hl = mode_hl .. '2', strings = { '█' } },
              '%<', -- Mark general truncate point
            }
            if table.concat({ git, diff, diagnostics, lsp }):len() > 0 then
              table.insert(tab, { hl = 'MiniStatuslineDevinfo2', strings = { '█' } })
              table.insert(tab, { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } })
              table.insert(tab, { hl = 'MiniStatuslineDevinfo2', strings = { '█' } })
              table.insert(tab, '%<') -- Mark general truncate point
            end
            table.insert(tab, { hl = 'MiniStatuslineFilename', strings = { ' ', filename, ' ' } })
            table.insert(tab, '%=')
            if fileinfo:len() > 0 then
              table.insert(tab, { hl = 'MiniStatuslineFileinfo2', strings = { '█' } })
              table.insert(tab, { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } })
              table.insert(tab, { hl = 'MiniStatuslineFileinfo2', strings = { '█' } })
            end

            table.insert(tab, { hl = mode_hl .. '2', strings = { '█' } })
            table.insert(tab, { hl = mode_hl, strings = { search, '%2l:%-2v' } })
            return combine_groups(tab)
          end,
          -- Content for inactive window(s)
          inactive = nil,
        },
        use_icons = vim.g.have_nerd_font,
        set_vim_settings = true,
      }

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
