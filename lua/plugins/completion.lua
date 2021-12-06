local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-c>"] = cmp.mapping.close(),
    ["<CR>"] =  cmp.mapping.confirm {
      select = false,
      behavior = cmp.ConfirmBehavior.Insert
    },
    ["<c-space>"] = cmp.mapping {
      i = cmp.mapping.complete(),
      c = function()
        if cmp.visible() then
          if not cmp.confirm { select = true } then
            return
          end
        else
          cmp.complete()
        end
      end,
    },
  },

  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path", keyword_length = 4 },
    { name = "buffer", keyword_length = 6 },
  },

  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
      },
    },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

cmp.setup.cmdline("/", {
  completion = {},
  sources = cmp.config.sources({
    { name = "nvim_lsp_document_symbol" },
  }, {}),
})

cmp.setup.cmdline(":", {
  completion = {},

  sources = cmp.config.sources({
    {
      name = "path",
    },
  }, {
    {
      name = "cmdline",
      max_item_count = 20,
      keyword_length = 4,
    },
  }),
})
