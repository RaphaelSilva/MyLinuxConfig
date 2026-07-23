return {
  -- 1. Mason: apenas baixa/gerencia os binários dos servidores (LSPs, Linters).
  -- Tag v1.11.0 = última linha 1.x compatível com Neovim 0.9.5. A 2.x exige
  -- Neovim 0.11+ e quebra o download do registro com E5560 no 0.9.5.
  {
    "williamboman/mason.nvim",
    tag = "v1.11.0",
    config = function()
      require("mason").setup()
    end,
  },

  -- 2. nvim-lspconfig: configura e inicia os servidores.
  -- Tag v1.8.0 é a última compatível com Neovim 0.9.5.
  -- NOTA: removemos o mason-lspconfig de propósito. Na versão 2.x ele passou a
  -- exigir Neovim 0.11+ (removeu o setup_handlers), então configuramos os
  -- servidores diretamente aqui — mais simples e estável no 0.9.5.
  {
    "neovim/nvim-lspconfig",
    tag = "v1.8.0",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Servidores a usar. Chave = nome no lspconfig | valor = pacote no Mason.
      -- (esse "de-para" era o que o mason-lspconfig fazia automaticamente)
      local servers = {
        pyright = "pyright",
        ts_ls   = "typescript-language-server",
      }

      -- Auto-instala pelo Mason o que ainda faltar (mantém o dotfiles reprodutível).
      -- Blindado: roda na main loop (vim.schedule_wrap evita o E5560 "vimL function
      -- must not be called in a lua loop callback") e sob pcall, para que uma falha de
      -- rede/registro nunca quebre a inicialização do Neovim.
      -- Obs.: pyright e ts_ls exigem Node/npm instalados no sistema.
      local function install_missing()
        local registry = require("mason-registry")
        for _, pkg_name in pairs(servers) do
          if registry.has_package(pkg_name) then
            local pkg = registry.get_package(pkg_name)
            if not pkg:is_installed() then
              pkg:install()
            end
          end
        end
      end

      pcall(function()
        local registry = require("mason-registry")
        registry.refresh(vim.schedule_wrap(function()
          pcall(install_missing)
        end))
      end)

      -- Aparência do Linter (erros/avisos na tela)
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
      })

      -- Atalhos, aplicados quando um LSP anexa a um buffer
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end

      -- Configura cada servidor diretamente
      for server, _ in pairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
        })
      end
    end,
  },
}
