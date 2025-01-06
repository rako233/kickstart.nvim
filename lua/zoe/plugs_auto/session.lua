return {
  {
    'rmagatti/auto-session',
    lazy = false,
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { 'node_modules', '.git', '.config' },
      auto_save = true,
      auto_create = true,
      auto_restore = true,
      auto_restore_last_session = false,
      use_git_branch = false,
      lazy_support = true,
      bypass_save_filetypes = {},
      close_unsupported_windows = true,
      args_allow_single_directory = true,
      args_allow_files_autosave = false,
      continue_restore_on_error = true,
      show_auto_restore_notif = false,
      cwd_change_handling = false,
      lsp_stop_on_restore = false,
      log_level = 'error',
      session_lens = {
        load_on_setup = true,
      },
    },
  },
}
