return {
  {
    'terrortylor/nvim-comment',
    enabled = true,
    dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('nvim_comment').setup {
        marker_padding = true,
        comment_empty = true,
        comment_empty_trim_whitespace = true,
        create_mappings = false,
        line_mapping = '<leader>ccl',
        operator_mapping = '<leader>cco',
        comment_chunk_text_object = '<leader>cci',
        hook = function()
          if vim.bo.filetype == 'vue' then
            require('ts_context_commentstring.internal').update_commentstring()
          end
        end,
      }
      vim.keymap.set('n', '<leader>ccl', '<Cmd>set operatorfunc=CommentOperator<CR>g@l', { noremap = true, desc = 'Comment [l]ine' })
      vim.keymap.set('n', '<leader>ccb', '<Cmd>set operatorfunc=CommentOperator<CR>g@', { noremap = true, desc = 'Comment [b]lock' })
    end,
  },
}
