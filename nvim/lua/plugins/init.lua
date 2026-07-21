local overrides = require "configs.overrides"

return {
  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = overrides.mason,
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },

  -- Treesitter (new API - no more nvim-treesitter.configs)
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- New nvim-treesitter uses vim.treesitter API directly
      local ts = overrides.treesitter
      -- Install parsers
      if ts.ensure_installed then
        local installed = require("nvim-treesitter.install").installed_parsers or {}
        for _, lang in ipairs(ts.ensure_installed) do
          if not vim.tbl_contains(installed, lang) then
            pcall(function() require("nvim-treesitter.install").install({ lang }) end)
          end
        end
      end
      -- Enable features (only for current buffer if it has a parser)
      if ts.highlight and ts.highlight.enable then
        pcall(function() vim.treesitter.start() end)
      end
    end,
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local mason_lspconfig = require "mason-lspconfig"
      mason_lspconfig.setup {
        ensure_installed = overrides.lspconfig.ensure_installed,
        automatic_enable = true,
      }
    end,
  },

  -- LSP Config loader
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require("conform").setup(require "configs.conform")
    end,
  },

  -- Copilot
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.cmd [[imap <silent><script><expr> <C-p> copilot#Accept("\<CR>")]]
      vim.api.nvim_set_keymap("i", "<M-]>", "<Plug>(copilot-next)", { silent = true })
      vim.api.nvim_set_keymap("i", "<M-[>", "<Plug>(copilot-previous)", { silent = true })
      vim.api.nvim_set_keymap("i", "<M-\\>", "<Plug>(copilot-dismiss)", { silent = true })
      vim.g.copilot_filetypes = { ["*"] = true }
    end,
  },

  -- Better escape
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
    lazy = false,
  },

  -- CMP + Snippets
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- Lspsaga
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup {
        ui = {
          border = "rounded",
          winblend = 10,
          expand = "",
          collapse = "",
          code_action = " ",
          incoming = " ",
          outgoing = " ",
          hover = " ",
          kind = {},
        },
        hover = { max_width = 0.8, max_height = 0.6, open_link = "gx" },
        diagnostic = {
          on_insert = false,
          show_code_action = true,
          show_source = true,
          jump_num_shortcut = true,
          max_width = 0.7,
          keys = { exec_action = "o", quit = "q", go_action = "g" },
        },
        code_action = {
          num_shortcut = true,
          show_server_name = false,
          extend_gitsigns = true,
          keys = { quit = "q", exec = "<CR>" },
        },
        lightbulb = { enable = true, enable_in_insert = true, sign = true, sign_priority = 40, virtual_text = true },
        preview = { lines_above = 0, lines_below = 10 },
        scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
        request_timeout = 2000,
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Prisma
  {
    "prisma/vim-prisma",
    ft = { "prisma" },
  },

  -- Dadbod (DB UI)
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = vim.fn.stdpath "data" .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_execute_on_save = false
      vim.g.db_ui_use_nvim_notify = true
    end,
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
  },

  -- TODO Comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("todo-comments").setup {
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        highlight = {
          multiline = true,
          keyword = "wide_bg",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
        },
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
      }
    end,
  },

  -- ============================================================
  -- LazyVim-inspired features
  -- ============================================================

  -- Which-Key: show keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = { enabled = true } },
      win = { border = "rounded" },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)
      wk.add {
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Terminal" },
        { "<leader>l", group = "LSP" },
        { "<leader>d", group = "Diagnostics/DB" },
        { "<leader>b", group = "Buffer" },
        { "<leader>h", group = "Hop/Split" },
        { "<leader>c", group = "Code" },
        { "<leader>r", group = "Rename" },
        { "[", group = "Previous" },
        { "]", group = "Next" },
      }
    end,
  },

  -- Flash: better hop/jump (by folke, author of lazy.nvim)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<leader>ss", mode = { "n" }, function() require("flash").jump() end, desc = "Flash: Jump to word" },
      { "<leader>st", mode = { "n" }, function() require("flash").treesitter() end, desc = "Flash: Treesitter" },
      { "<leader>sr", mode = { "n" }, function() require("flash").treesitter_search() end, desc = "Flash: Treesitter Search" },
      { "<leader>sl", mode = { "n" }, function() require("flash").jump({ search = { mode = "search" } }) end, desc = "Flash: Line" },
    },
  },

  -- Trouble: better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      use_diagnostic_signs = true,
      auto_close = true,
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
    },
  },

  -- Telescope improvements
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension "fzf"
        end,
      },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/", "target/", "dist/", "build/" },
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
      },
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next git hunk" })

        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous git hunk" })

        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview git hunk" })
        map("n", "<leader>gb", gs.blame_line, { desc = "Git blame line" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Git diff" })
      end,
    },
  },

  -- Dashboard (lazyvim style)
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require "alpha"
      local dashboard = require "alpha.themes.dashboard"

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("w", "  Find Word", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("b", "  Buffers", "<cmd>Telescope buffers<cr>"),
        dashboard.button("g", "  Git Status", "<cmd>Telescope git_status<cr>"),
        dashboard.button("c", "  Settings", "<cmd>e $MYVIMRC<cr>"),
        dashboard.button("l", "  Lazy", "<cmd>Lazy<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
      }

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      alpha.setup(dashboard.opts)

      -- Disable banner on non-dashboard buffers
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- Mini.move: move lines/blocks with alt+hjkl
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
    },
  },

  -- Mini.surround: surround text objects
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "",
      },
    },
  },
}
