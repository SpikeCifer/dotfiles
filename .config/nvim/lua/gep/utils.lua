return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },

    {
        "tpope/vim-surround",
        event = "InsertEnter"
    },

    "tpope/vim-commentary",

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("ibl").setup()
        end
    },
}
