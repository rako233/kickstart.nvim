if vim.env.NVIM_QUICK_EXIT == '1' then vim.keymap.set('n', '<Esc>', '<cmd>qa!<CR>', { noremap = true, silent = true }) end
