-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
      'MunifTanjim/nui.nvim',
    },
    lazy = false,
    ---@module 'neo-tree',
    ---@type neotree.Config?
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- Show hidden files
          hide_dotfiles = false, -- Do not hide dotfiles
          hide_gitignored = false, -- Do not hide git ignored files
        },
        use_libuv_file_watcher = true, -- Use libuv for file watching
      },
    },

    -- Backslash key to toggle Neo-tree
    vim.keymap.set('n', '\\', ':Neotree toggle<CR>', { noremap = true, silent = true }),
  },
}
