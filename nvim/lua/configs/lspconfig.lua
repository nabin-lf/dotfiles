local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

vim.diagnostic.config {
  virtual_text = {
    source = "always",
    prefix = "●",
    spacing = 2,
  },
  float = {
    source = "always",
    border = border,
    max_width = 120,
    wrap = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border, max_width = 80 })

-- Setup LSP servers
local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local util = require "lspconfig.util"

-- Helper to setup server with default options
local function setup_server(server, opts)
  opts = opts or {}
  opts.on_attach = opts.on_attach or function(client, bufnr)
    local map = vim.keymap.set
    local lsp_opts = { noremap = true, silent = true, buffer = bufnr }
    map("n", "K", ":Lspsaga hover_doc<CR>", lsp_opts)
    map("n", "gdf", ":Lspsaga peek_definition<CR>", lsp_opts)
    map("n", "gd", vim.lsp.buf.definition, lsp_opts)
    map("n", "gf", ":Lspsaga finder<CR>", lsp_opts)
    map("n", "<leader>ca", ":Lspsaga code_action<CR>", lsp_opts)
    map("n", "<leader>rn", ":Lspsaga rename<CR>", lsp_opts)
    map("n", "<leader>d", ":Lspsaga show_line_diagnostics<CR>", lsp_opts)
    map("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", lsp_opts)
    map("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", lsp_opts)
    map("n", "<leader>lf", function()
      vim.diagnostic.open_float { border = "rounded" }
    end, lsp_opts)
  end
  opts.capabilities = opts.capabilities or vim.lsp.protocol.make_client_capabilities()
  lspconfig[server].setup(opts)
end

setup_server "gopls"
setup_server "ts_ls"
setup_server "html"
setup_server "cssls"
setup_server "clangd"
setup_server "jsonls"
setup_server "yamlls"
setup_server "biome"
setup_server "prismals"

-- Buf LSP for proto files
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
