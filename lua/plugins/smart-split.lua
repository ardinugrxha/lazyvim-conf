return {
    { 'nvim-focus/focus.nvim', lazy = false },
    {
        "mg979/vim-visual-multi",
        lazy = false,
    },
    {
        "xiyaowong/transparent.nvim",
    },
    {
        "APZelos/blamer.nvim"
    },
    {
        "EdenEast/nightfox.nvim"
    },
    {
        'nvim-pack/nvim-spectre'
    },
    {
        'barrett-ruth/live-server.nvim',
        build = 'pnpm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = true
    }

}
