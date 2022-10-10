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

-- Autocommand tha reloads neovim whenever you save the plugins.lua file
vim.cmd[[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Don"t error out on first use (pcall is used )
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

    -- Completion Suggestions
    use {
        "hrsh7th/nvim-cmp",
        -- config = function()
        --     require("")
        wants = { "LuaSnip" },
        requires = {
            "hrsh7th/cmp-buffer",        -- Buffer Completions
            "hrsh7th/cmp-path",          -- Path Completions
            "saadparwaiz1/cmp_luasnip",  -- Snippet Completion
            "hrsh7th/cmp-nvim-lsp",
            "rafamadriz/friendly-snippets",
            {
                "L3MON4D3/LuaSnip",
                wants = "friendly-snippets",
            },
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

    -- LSP
    use {
        "williamboman/nvim-lsp-installer",  -- LSP Installer
        requires = {
            "neovim/nvim-lspconfig", -- Enable LSP
        }
    }

    -- Auto set up configuration after cloning packer.nvim (Place it at the end)
    if ensure_packer() then
        require("packer").sync()
    end
end)
