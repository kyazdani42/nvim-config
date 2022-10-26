local function ensure_installed(repo)
  local ok, results = pcall(vim.fs.find, repo, { path = "~/.local/share/nvim/site/pack/packer", type = "directory" })
  return ok and #results > 0
end

if not ensure_installed("packer") or not ensure_installed("aniseed") then
  print("Configuration loading was cancelled. Please install packer.nvim and aniseed.")
  return
end

vim.g["aniseed#env"] = {
  module = "yazdan.init",
  compile = true
}
