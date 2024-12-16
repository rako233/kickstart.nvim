return {
  {
    'iamcco/markdown-preview.nvim',
    enabled = true,
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    config = function()
      vim.g.mkdp_filetypes = { 'markdown' }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_refresh_slow = 0
      -- vim.g.mkdp_browser = '/usr/bin/xdg_open'
      vim.g.mkdb_echo_preview_url = 1
    end,
    ft = { 'markdown' },
  },
}
