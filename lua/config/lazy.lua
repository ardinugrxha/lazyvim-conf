local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "onedark", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})



local ignore_filetypes = { 'neo-tree' }
local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

-- local augroup =
--     vim.api.nvim_create_augroup('FocusDisable', { clear = true })

-- vim.api.nvim_create_autocmd('WinEnter', {
--   group = augroup,
--   callback = function(_)
--     if vim.tbl_contains(ignore_buftypes, vim.bo.buftype)
--     then
--       vim.w.focus_disable = true
--     else
--       vim.w.focus_disable = false
--     end
--   end,
--   desc = 'Disable focus autoresize for BufType',
-- })

-- vim.api.nvim_create_autocmd('FileType', {
--   group = augroup,
--   callback = function(_)
--     if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
--       vim.b.focus_disable = true
--     else
--       vim.b.focus_disable = false
--     end
--   end,
--   desc = 'Disable focus autoresize for FileType',
-- })
vim.g.blamer_enabled = true
