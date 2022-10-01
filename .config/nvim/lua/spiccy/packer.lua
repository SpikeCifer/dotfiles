-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- the Package Manager
	use 'wbthomason/packer.nvim' 
    
    -- Configurations for Nvim LSP
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    -- Themes
    use 'rafamadriz/neon' 

    -- Utilities
	use 'vim-airline/vim-airline' -- The menu at the bottom
    use {
        "folke/trouble.nvim",
        requires= "kyazdani42/nvim-web-devicons",
        config = function() 
            require("trouble").setup {
                -- Configs
                -- Empty for defaults
            }
        end
    }

	use 'dmerejkowsky/vim-ale' -- Async linter (Will replace)
    
    -- Show colors of color codes
	use 'lilydjwg/colorizer' 
    
    -- Autocomplete Engine
    use 'ms-jpq/coq_nvim' 
    use 'ms-jpq/coq.artifacts'
end)
