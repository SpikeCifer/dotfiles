local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Appearance
    {
        -- "folke/tokyonight.nvim",
        -- "ellisonleao/gruvbox.nvim",
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "kanagawa-wave"
        end
    },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, },

    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                component_separators = "│",
                section_separators = "",
            }
        }
    },

    -- The TPope collection
    "tpope/vim-commentary",

    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
        },
    },

    -- TreeSitter
    "nvim-treesitter/nvim-treesitter-context",
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            pcall(require("nvim-treesitter.install").update { with_sync = true })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim",       tag = "legacy", opt = {} },
            "folke/neodev.nvim", -- Allows for autocompletion inside nvim files
        },
    },

    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk,
                    { buffer = bufnr, desc = "Preview git hunk" })

                -- don"t override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ "n", "v" }, "]c", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ "n", "v" }, "[c", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
        },
    },

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            "hrsh7th/cmp-nvim-lsp",

            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "ray-x/lsp_signature.nvim",

            "rafamadriz/friendly-snippets",
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Neorg
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = { workspaces = { notes = "~/Documents/MyNotes" } }
                    },
                    ["core.integrations.treesitter"] = {},
                    ["core.autocommands"] = {},
                    ["core.syntax"] = {},
                },
            }
        end
    },

    -- Nvim-tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {}
        end,
    },

    { -- Folding
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        config = function()
            require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end
            })
        end
    },

    -- Miscellaneous
    { "kylechui/nvim-surround", config = true },
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} }
})
