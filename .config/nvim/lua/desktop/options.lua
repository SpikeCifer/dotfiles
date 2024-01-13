local opt = vim.opt

-- General Appearance
opt.number = true
opt.wrap = false
opt.cursorline = true	    -- (Cursor Line)
opt.colorcolumn = "80"	    -- Highlight Column
opt.termguicolors = true
opt.showmode = false
opt.signcolumn = "auto"

-- Undo Utils
opt.undofile = true
opt.undolevels = 100

-- Searching
opt.ignorecase = true
opt.smartcase = true	    -- Don't ignore case if pattern contains uppercase
opt.infercase = true	    -- wo -> world, wO -> wOrld, Wo -> World

-- Indenting
opt.shiftwidth = 4	        -- Number of spaces to use for indenting
opt.tabstop = 4	            -- Number of spaces tabs use
opt.expandtab = true	    -- Use spaces instead of tabs
opt.spell = true            -- Spell Checking
opt.shiftround = true       -- Round indenting

-- Time
opt.updatetime = 250       -- Autosave after X ms
opt.timeoutlen = 500       -- Time in ms to wait for a mapped sequence to complete

-- Completion Menu
opt.completeopt = 'menu,menuone,noselect' -- Use the popup menu always and force user to select

-- Folding
opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

opt.clipboard = "unnamedplus"
vim.g.markdown_recommended_style = 0

