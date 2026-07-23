-- Ativa a numeração de linhas e a numeração relativa (ótima para navegação)
vim.opt.number = true
vim.opt.relativenumber = true

-- Configura a tabulação para 4 espaços
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Ativa o destaque da linha onde o cursor está
vim.opt.cursorline = true

-- Habilita o mouse (útil no começo para rolar a tela ou clicar)
vim.opt.mouse = 'a'

-- Força o uso de UTF-8 para evitar problemas com acentos (ç, á, ã, etc.)
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Habilita True Color no Neovim
vim.opt.termguicolors = false
