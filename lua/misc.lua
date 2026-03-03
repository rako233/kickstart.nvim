GetConfigDir = function(dir)
  local config_path = (vim.fn.stdpath 'config') .. dir
  return config_path
end

ExistsInPath = function(nameToCheck)
  local cwDir = GetConfigDir '/lua'

  -- Get all files and directories in CWD
  local cwdContent = vim.split(vim.fn.glob(cwDir .. '/*'), '\n', { trimempty = true })

  -- Check if specified file or directory exists
  local fullNameToCheck = cwDir .. '/' .. nameToCheck
  print('Checking for: "' .. fullNameToCheck .. '"')
  for _, cwdItem in pairs(cwdContent) do
    if cwdItem == fullNameToCheck then
      return true
    end
  end
  return false
end

FileList = function()
  local cwDir = GetConfigDir '/lua'

  -- Get all files and directories in CWD
  local cwdContent = vim.split(vim.fn.glob(cwDir .. '/*.lua'), '\n', { trimempty = true })
  return cwdContent
end

P = function(v)
  print(vim.inspect(v))
  return v
end

GetMode = function()
  P(vim.fn.mode())
end
