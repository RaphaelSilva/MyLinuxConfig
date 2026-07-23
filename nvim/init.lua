-- 1. Carrega as configurações básicas do passo anterior
require("core.options")

-- 2. Código de bootstrap do Lazy.nvim (instala automaticamente se não existir)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com",
    "--branch=stable", -- última versão estável
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Inicializa o Lazy.nvim e aponta para a pasta onde vão ficar os plugins
require("lazy").setup("plugins")

