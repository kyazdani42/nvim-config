local packer_dir = "~/.local/share/nvim/site/pack/packer"

local ensure_installed = function(user, repo)
	local ok, results = pcall(vim.fs.find, repo, { path = packer_dir, type = "directory" })
	if not ok or #results == 0 then
		local cmd = string.format("!git clone https://github.com/%s/%s %s/start/%s", user, repo, packer_dir, repo)
		vim.cmd(cmd)
		vim.cmd("packadd " .. repo)
	end
end

ensure_installed("lewis6991", "packer.nvim")
ensure_installed("Olical", "aniseed")

vim.g["aniseed#env"] = {
  module = "yazdan.init",
  compile = true
}

-- force initialize init before plugins
require "yazdan"
