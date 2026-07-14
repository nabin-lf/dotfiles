return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "javascript", "typescript",
        "json", "yaml", "bash", "markdown",
        "tsx", "jsx",
        "go", "gomod", "gosum", "gowork",
      },
    },
  },
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Tree" },
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle Tree" },
    },
    config = function()
      require("nvim-tree").setup {
        view = { width = 30 },
        git = { enable = true },
        filters = { dotfiles = false },
      }
    end,
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Find Word" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
    },
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/", "target/" },
        },
      }
    end,
  },
  -- Hop (quick jump)
  {
    "smoka7/hop.nvim",
    cmd = "Hop",
    keys = {
      { "<leader>hw", "<cmd>HopWord<cr>", desc = "Hop Word" },
      { "<leader>hl", "<cmd>HopLine<cr>", desc = "Hop Line" },
    },
    config = function()
      require("hop").setup()
    end,
  },
  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=50<cr>", desc = "Vertical Terminal" },
    },
    config = function()
      require("toggleterm").setup {
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = { border = "rounded" },
      }
    end,
  },
}
