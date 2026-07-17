require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Find files
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find Word (Grep)" })
map("n", "<leader>fa", "<cmd>Telescope commands<cr>", { desc = "Find All Commands" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find Recent Files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })

-- File explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Tree" })

-- Splits
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Resize splits
map("n", "<A-h>", "<cmd>resize -2<cr>", { desc = "Shrink split height" })
map("n", "<A-j>", "<cmd>resize +2<cr>", { desc = "Increase split height" })
map("n", "<A-k>", "<cmd>vertical resize -2<cr>", { desc = "Shrink split width" })
map("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase split width" })

-- Quick actions
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>x", "<cmd>wq<cr>", { desc = "Save & Quit" })
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Buffer management
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Git
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })

-- Terminal
map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal Terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=50<cr>", { desc = "Vertical Terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Hop
map("n", "<leader>hw", "<cmd>HopWord<cr>", { desc = "Hop to Word" })
map("n", "<leader>hl", "<cmd>HopLine<cr>", { desc = "Hop to Line" })

-- TODO
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
map("n", "<leader>fq", "<cmd>TodoQuickFix<cr>", { desc = "Todo Quickfix" })

-- Diagnostics
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })

-- Formatter notification
map("n", "<leader>cf", function()
  local conform = require "conform"
  local bufnr = vim.api.nvim_get_current_buf()
  local formatters = conform.list_formatters_for_buffer(bufnr)
  if formatters and #formatters > 0 then
    local names = {}
    for _, f in ipairs(formatters) do table.insert(names, f.name) end
    vim.notify("Formatters: " .. table.concat(names, ", "), vim.log.levels.INFO)
  else
    vim.notify("No formatters for this file", vim.log.levels.WARN)
  end
end, { desc = "Show active formatters" })
