vim.cmd[[packadd packer.nvim]]

-- Bootstarp Packer (Automatically install and set up on any machine, 
-- exactly as presented in the official repo)
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        })
        vim.cmd[[packadd packer.nvim]]
        return true
    end
    return false
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd[[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Don"t error out on first use (pcall is used)
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
} 

return packer.startup(function(use)
    use "wbthomason/packer.nvim"    -- Have packer manage itself
    use "nvim-lua/plenary.nvim"     -- One of the most used APIs
    use "folke/tokyonight.nvim"     -- Current Theme (Consider Transparent?)

    -- Treesitter(Actually, it was pretty easy to config)
    use {
        "nvim-treesitter/nvim-treesitter",
        event = {"BufReadPre", "BufNewFile"},
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("spiccy.treesitter").setup()
        end,
        requires = {
            { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
        },
    }

    -- LSP
    use {
        "williamboman/mason.nvim",
        setup = require("mason").setup()
    }

    use {
        "williamboman/mason-lspconfig.nvim",
        setup = require("mason-lspconfig").setup()
    }

    use "neovim/nvim-lspconfig"

    use "romgrk/barbar.nvim"

    -- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
            "rafamadriz/friendly-snippets",
        },
    }

    -- Comment lines
    use {
        "numToStr/Comment.nvim",
        opt = true,
        keys = { "gc", "gcc", "gbc" },
        config = function()
            require("Comment").setup {}
        end,
    }

    -- Tree File Explorer
    use {
        "nvim-tree/nvim-tree.lua",
        requires = "nvim-tree/nvim-web-devicons",
        run = ":NvimTreeToggle"
    }

    -- Surround selected text with anything you want
    use {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    }

    -- Automatically create pairs
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end
    }

    -- Show Linter and other stuff at the bottom
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function ()
            require("trouble").setup {}
        end,
        run = ":Trouble"
    }

    -- Auto set up configuration after cloning packer.nvim (Place it at the end)
    if ensure_packer() then
        require("packer").sync()
    end
end)
