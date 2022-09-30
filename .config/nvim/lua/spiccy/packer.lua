-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use 'wbthomason/packer.nvim' -- the Package Manager
    -- Themes
    use 'rafamadriz/neon' -- My current Theme
    
    -- Utilities
	use 'vim-airline/vim-airline' -- The menu at the bottom
	use 'dmerejkowsky/vim-ale' -- Async linter (Will replace)
	use 'lilydjwg/colorizer' -- Show colors of color codes
    
    -- Autocomplete Engine
    use 'ms-jpq/coq_nvim' 
    use 'ms-jpq/coq.artifacts'
end)
