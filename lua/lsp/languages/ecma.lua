local uv = vim.loop
local M = {}

local root_pattern = function(fname, ...)
  return require'lspconfig.util'.root_pattern(...)(fname)
end

local function get_eslint_root(fname)
  local eslintrc_root = root_pattern(fname, '.eslintrc', '.eslintrc.json', '.eslintrc.js')

  if eslintrc_root ~= nil then
    return eslintrc_root
  end

  local package_json_root = root_pattern(fname, 'package.json')
  if not package_json_root then
    return nil
  end

  local package_json = package_json_root .. '/package.json'
  if not uv.fs_access(package_json, 'R') then
    return nil
  end

  local ok, decoded = pcall(vim.fn.json_decode, vim.fn.readfile(package_json))
  if not ok then
    return nil
  end

  return decoded["eslintConfig"] and package_json_root or nil
end

local function get_rome_config_root(fname)
  return root_pattern(fname, 'rome.json', '.config/rome.rjson')
end

local function eslint()
  local eslint_cmd = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
    formatStdin = true
  }

  require "lspconfig".efm.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = true
      client.resolved_capabilities.goto_definition = false
    end,
    root_dir = function(fname)
      if get_rome_config_root(fname) then
        return nil
      end
      return get_eslint_root(fname)
    end,
    settings = {
      languages = {
        javascript = {eslint_cmd},
        javascriptreact = {eslint_cmd},
        ["javascript.jsx"] = {eslint_cmd},
        typescript = {eslint_cmd},
        ["typescript.tsx"] = {eslint_cmd},
        typescriptreact = {eslint_cmd}
      }
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescript.tsx",
      "typescriptreact"
    },
  }
end

local function tsserver(cap)
  require'lspconfig'.tsserver.setup {
    capabilities = cap,
    on_attach = function(client, bufnr)
      client.resolved_capabilities.document_formatting = false
      require'lsp.utils'.on_attach(client, bufnr)
    end,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  }
end

local function denols()
  require'lspconfig'.denols.setup {
    cmd = { "deno", "lsp" },
    filetypes = { "javascript", "typescript" },
    init_options = {
      enable = true,
      lint = true,
      unstable = false
    },
    handlers = vim.lsp.handlers,
    root_dir = function(fname)
      if get_eslint_root(fname) or get_rome_config_root(fname) then
        return nil
      end

      return vim.fn.fnamemodify(fname, ':h')
    end,
  }
end

local function rome()
  require'lspconfig'.rome.setup {
    root_dir = get_rome_config_root
  }
end

function M.setup(cap)
  tsserver(cap)
  eslint()
  denols()
  rome()
end

return M
