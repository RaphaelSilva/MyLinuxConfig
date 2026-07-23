return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8', -- Versão estável do plugin
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Dependência obrigatória
    lazy = false,
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      -- Configuração global do Telescope para gerenciar arquivos ocultos
      telescope.setup({
        pickers = {
          find_files = {
            hidden = true, -- Mostra arquivos ocultos (ex: .claude, .env, etc.)
            -- Opcional: Se quiser que ele busque mesmo dentro de arquivos no .gitignore,
            -- remova o comentário da linha abaixo mudando para true:
            -- no_ignore = false,
          }
        },
        defaults = {
            file_ignore_patterns = {
                "node_modules/.*",
                "%.git/.*",
                "target/.*",
                "build/.*",
                "dist/.*"
            }
        }
      })
      
      -- Configura os atalhos de teclado (Keymaps) de forma fácil de lembrar:
      -- \ + f + f (Find Files): Busca arquivos pelo nome
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Buscar Arquivos (incluindo ocultos)" })
      -- \ + f + g (Live Grep): Busca textos/palavras dentro dos arquivos
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Buscar Texto" })
      -- \ + f + b (Buffers): Mostra os arquivos que já estão abertos
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Listar Buffers" })
    end
  }
}

