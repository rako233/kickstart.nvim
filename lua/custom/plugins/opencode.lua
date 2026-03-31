return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
      picker = { enabled = true },
      terminal = { enabled = true },
    },
  },

  {
    'nickjvandyke/opencode.nvim',
    dependencies = {
      'folke/snacks.nvim',
      'folke/which-key.nvim',
    },

    -- opencode.nvim reads options from vim.g.opencode_opts
    init = function()
      local opencodeCmd = 'opencode --port'

      ---@type snacks.terminal.Opts
      local snacksTerminalOpts = {
        win = {
          position = 'right',
          width = 0.4,
          enter = false,
          on_win = function(win)
            -- Makes the embedded opencode terminal behave correctly inside Neovim
            require('opencode.terminal').setup(win.win)
          end,
        },
      }

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function() require('snacks.terminal').open(opencodeCmd, snacksTerminalOpts) end,
          stop = function()
            local term = require('snacks.terminal').get(opencodeCmd, snacksTerminalOpts)
            if term then term:close() end
          end,
          toggle = function() require('snacks.terminal').toggle(opencodeCmd, snacksTerminalOpts) end,
        },

        contexts = {
          ['@buffer'] = function(context) return context:buffer() end,
          ['@buffers'] = function(context) return context:buffers() end,
          ['@visible'] = function(context) return context:visible_text() end,
          ['@diagnostics'] = function(context) return context:diagnostics() end,
          ['@quickfix'] = function(context) return context:quickfix() end,
          ['@diff'] = function(context) return context:git_diff() end,
          ['@marks'] = function(context) return context:marks() end,
          ['@this'] = function(context) return context:this() end,
        },

        prompts = {
          ask = {
            prompt = '',
            ask = true,
            submit = true,
          },
          explain = {
            prompt = 'Explain @buffer',
            submit = true,
          },
          fix = {
            prompt = 'Review @diagnostics and propose a fix for @buffer',
            submit = true,
          },
          tests = {
            prompt = 'Write tests for @buffer',
            submit = true,
          },
          diff = {
            prompt = 'Review these changes:\n@diff',
            submit = true,
          },
        },

        lsp = {
          enabled = false,
        },

        events = {
          notify = true,
        },
      }
    end,

    config = function()
      local opencode = require 'opencode'
      local wk = require 'which-key'

      local function askSelection()
        local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        opencode.ask '@selection\n'
      end

      -- Actual keymaps
      vim.keymap.set('n', '<leader>oo', function() opencode.toggle() end, { desc = 'Toggle terminal' })

      vim.keymap.set('n', '<leader>oa', function() opencode.ask() end, { desc = 'Ask' })

      vim.keymap.set('v', '<leader>oa', askSelection, { desc = 'Ask selection' })

      vim.keymap.set('n', '<leader>os', function() opencode.select() end, { desc = 'Select prompt' })

      vim.keymap.set('n', '<leader>oe', function() opencode.prompt 'explain' end, { desc = 'Explain buffer' })

      vim.keymap.set('n', '<leader>of', function() opencode.prompt 'fix' end, { desc = 'Fix diagnostics' })

      vim.keymap.set('n', '<leader>ot', function() opencode.prompt 'tests' end, { desc = 'Write tests' })

      vim.keymap.set('n', '<leader>od', function() opencode.prompt 'diff' end, { desc = 'Review git diff' })

      vim.keymap.set('n', '<leader>on', function() opencode.command 'session.new' end, { desc = 'New session' })

      vim.keymap.set('n', '<leader>ol', function() opencode.command 'session.list' end, { desc = 'List sessions' })

      vim.keymap.set('n', '<leader>oi', function() opencode.command 'session.interrupt' end, { desc = 'Interrupt session' })

      -- which-key group
      wk.add {
        { '<leader>o', group = 'Opencode' },
        { '<leader>oo', desc = 'Toggle terminal' },
        { '<leader>oa', desc = 'Ask' },
        { '<leader>os', desc = 'Select prompt' },
        { '<leader>oe', desc = 'Explain buffer' },
        { '<leader>of', desc = 'Fix diagnostics' },
        { '<leader>ot', desc = 'Write tests' },
        { '<leader>od', desc = 'Review git diff' },
        { '<leader>on', desc = 'New session' },
        { '<leader>ol', desc = 'List sessions' },
        { '<leader>oi', desc = 'Interrupt session' },
      }
    end,
  },
}
