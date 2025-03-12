return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          fish = { "fish_indent" },
          solidity = { "prettier" },
          wasm = { "wasmfmt" },
          dockerfile = { "dockfmt" },
          yaml = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          proto = { "buff" },
          markdown = { "prettier" },
          env = { "prettier" },
          xml = { "xmllint" },
          sql = { "pgformatter" },
          python = { "black", "isort" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          java = { "google-java-format" },
          gitignore = { "prettier" }
        },
      }

      -- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      --   callback = function()
      --     conform.format {
      --       lsp_fallback = true,
      --       async = false,
      --       timeout_ms = 1000,
      --     }
      --   end,
      -- })

      vim.keymap.set({ "n", "v" }, "<leader>ll", function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    events = { "BufWritePre", "BufNewFile" },
    confg = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        fish = { "fish" },
        solidity = { "solhint" },
        wasm = { "wasm-tools" },
        dockerfile = { "hadolint" },
        proto = { "buff" },
        markdownlint = { "markdownlint-cli2" },
        env = { "dotenv-linter" },
        xml = { "xmllint" },
        sql = { "sqlfluff" },
        python = { "pylint", "mypy" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        java = { "checkstyle" },
        gitcommit = { "gitlint" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "shfmt",
        "shellcheck",
        "fish-lsp", -- IS NOT WORKING FOR NOW
        "solidity-ls",
        "prettier",
        -- "wamr",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint",
        "buf",
        "protolint",
        "marksman",
        "markdownlint-cli2",
        "lemminx",
        "sqls",
        "sqlfluff",
        "pyright",
        "black",
        "isort",
        "mypy",
        "pylint",
        "typescript-language-server",
        "eslint_d",
        "tailwindcss-language-server",
        "jdtls",
        "google-java-format",
        "checkstyle",
        "pmd"
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "rust",
        "java",
        "javascript",
        "typescript",
        "bash",
        "fish",
        "solidity",
        "python",
        --"wasm",
        "dockerfile",
        "yaml",
        "proto",
        "markdown",
        "xml",
        "sql",
        "gitignore"
      },
      highlight = {
        enable = true,
      },
    },
  },
  {
    "heavenshell/vim-pydocstring",
    build = "make install",
    ft = "python",
    config = function()
      vim.g.pydocstring_formatter = "google" -- Use Google-style docstrings
      vim.g.pydocstring_enable_mapping = 0 -- Disable default mappings
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    confg = function()
      require("render-markdown").setup {}
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java"
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        {
          filter = { event = "notify", find = "No information available" },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require "illuminate"
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "mbbill/undotree",
    config = function()
      vim.keymap.set("v", "<leader><F5>", vim.cmd.UndotreeToggle)
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {}
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = "CopilotChat",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {},
  },
}
