require "nvchad.autocmds"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspsagaMappings", {}),
  callback = function(ev)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "Lspsaga: " .. desc })
    end

    map("K", "<cmd>Lspsaga hover_doc<cr>", "Hover")
    map("<leader>d", "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics")
    map("<leader>D", "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Cursor Diagnostics")
    map("gd", "<cmd>Lspsaga goto_definition<cr>", "Goto Definition")
    map("<leader>ca", "<cmd>Lspsaga code_action<cr>", "Code Action")
    map("<leader>rn", "<cmd>Lspsaga rename<cr>", "Rename")
    map("[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic")
    map("]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic")
  end,
})
