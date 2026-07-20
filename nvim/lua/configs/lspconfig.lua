vim.diagnostic.config {
  virtual_text = {
    source = "always",
    prefix = "●",
    spacing = 2,
  },
  float = {
    source = "always",
    border = "rounded",
    max_width = 120,
    wrap = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Disable native LSP hover/signature handlers (Lspsaga handles these)
-- This prevents the double-popup issue
vim.lsp.handlers["textDocument/hover"] = function() end
vim.lsp.handlers["textDocument/signatureHelp"] = function() end

-- Setup LSP servers using new vim.lsp.config API
local servers = {
  gopls = {},
  ts_ls = {},
  html = {},
  cssls = {},
  clangd = {},
  jsonls = {},
  yamlls = {},
  biome = {},
  prismals = {},
}

for server, opts in pairs(servers) do
  opts.on_attach = function(client, bufnr)
    -- Lspsaga handles all UI - clear native LSP mappings
    -- Don't set K, gd, etc here - Lspsaga does it via its own setup
  end
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

-- Buf LSP for proto files (manual start, no lspconfig needed)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "proto",
  callback = function(args)
    vim.lsp.start({
      name = "buf_ls",
      cmd = { "buf", "lsp", "serve" },
      root_dir = vim.fs.root(args.buf, { ".git", "buf.work.yaml", "buf.yaml" })
        or vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
    })
  end,
})
