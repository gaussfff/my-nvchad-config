-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "marksman",
  "lemminx",
  "pyright",
  "tailwindcss"
  -- "fish-lsp",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.jdtls.setup {
  cmd = { "jdtls" },
  root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git"),
  settings = {
    java = {
      referencesCodeLens = { enabled = true },
      implementationsCodeLens = { enabled = true },
      inlayHints = { parameterNames = { enabled = "all" } },
    }
  }
}

lspconfig.ts_ls.setup {
  filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" }
}

lspconfig.eslint.setup {
  filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
}

lspconfig.sqls.setup {
  settings = {
    sqls = {
      connections = {
        {
          driver = "postgresql",
          -- YES IT'S REAL CREDENTIALS OF PROD
          dataSourceName = "host=localhost port=5432 user=postgres password=yourpassword dbname=yourdb sslmode=disable",
        },
      },
    },
  },
}

lspconfig.buf_ls.setup {
  cmd = { "bufls", "serve" },
  filetypes = { "proto" },
  root_dir = lspconfig.util.root_pattern("buf.work.yaml", ".git"),
}

lspconfig.solidity.setup {
  settings = {
    solidity = {
      includePath = "",
      remapping = { ["@OpenZeppelin/"] = "OpenZeppelin/openzeppelin-contracts@4.6.0/" },
      allowPaths = {},
      root_dir = lspconfig.util.root_pattern(
        "package.json",
        ".git",
        "hardhat.config.js",
        "foundry.toml",
        "truffle-config.js"
      ) or vim.fn.getcwd(),
    },
  },
}
