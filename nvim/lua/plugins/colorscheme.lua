return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Carrega o tema imediatamente ao abrir o editor
    priority = 1000, -- Garante que ele carregue antes de qualquer outro plugin
    config = function()
      -- Define o estilo do tema (pode ser 'storm', 'night' ou 'moon')
      vim.g.tokyonight_style = "night" 
      -- Aplica o tema ao Neovim
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}

