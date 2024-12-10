return {
--    'MeanderingProgrammer/markdown.nvim',
--    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
--    dependencies = { 'nvim-treesitter/nvim-treesitter' },
--    config = function()
--        require('render-markdown').setup({})
--    end,
    "OXY2DEV/markview.nvim",
    lazy = false,      -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}
