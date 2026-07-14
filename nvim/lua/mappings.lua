require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

-- ============================================
-- Insert mode navigation (NvChad style)
-- ============================================
map("i", "<C-h>", "<Left>", { desc = "Move left in insert mode" })
map("i", "<C-j>", "<Down>", { desc = "Move down in insert mode" })
map("i", "<C-k>", "<Up>", { desc = "Move up in insert mode" })
map("i", "<C-l>", "<Right>", { desc = "Move right in insert mode" })

-- ============================================
-- Leader = Space (NvChad default)
-- ============================================

-- Find files
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })

-- Find word (grep)
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find Word (Grep)" })

-- Find all (buffers + files + recent)
map("n", "<leader>fa", "<cmd>Telescope commands<cr>", { desc = "Find All Commands" })

-- Find recent files
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find Recent Files" })

-- Find buffers
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })

-- Leader+E = File explorer (nvim-tree)
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })

-- Ctrl+N = Toggle tree (same as Leader+E)
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Tree" })

-- ============================================
-- Splits (NvChad style)
-- ============================================
map("n", "<leader>h", "<cmd>split<cr>", { desc = "Horizontal Split" })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- Navigate splits with Ctrl+hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Resize splits with Alt+hjkl
map("n", "<A-h>", "<cmd>resize -2<cr>", { desc = "Shrink split height" })
map("n", "<A-j>", "<cmd>resize +2<cr>", { desc = "Increase split height" })
map("n", "<A-k>", "<cmd>vertical resize -2<cr>", { desc = "Shrink split width" })
map("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase split width" })

-- ============================================
-- Quick actions
-- ============================================
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>x", "<cmd>wq<cr>", { desc = "Save & Quit" })

-- Clear search
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Better paste (don't yank replaced text)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- ============================================
-- NvChad extras (you probably don't know these)
-- ============================================

-- Hop (quick jump to any word on screen)
map("n", "<leader>hw", "<cmd>HopWord<cr>", { desc = "Hop to Word" })
map("n", "<leader>hl", "<cmd>HopLine<cr>", { desc = "Hop to Line" })

-- Telescope git status
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })

-- Telescope git commits
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git Commits" })

-- Terminal toggle
map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Horizontal Terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=50<cr>", { desc = "Vertical Terminal" })

-- Close buffer without closing window
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Close Buffer" })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
