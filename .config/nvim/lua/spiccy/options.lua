local options = {
    clipboard = "unnamedplus", 	-- Allow access to system clipboard

    -- General Appearance
    termguicolors = true, 	    -- Enable 24-bit RGB colors in terminal
    number = true, 		        -- Show line numbers
    relativenumber = true, 	    -- Show relative number lines
    wrap = false, 		        -- Don't wrap lines
    numberwidth = 2,            -- Set number column width (default 4)

    -- Tabs
    tabstop = 4,                -- Insert 4 spaces for a tab
    shiftwidth = 4,             -- Insert 4 spaces for each indentation
    expandtab = true,		    -- Convert tabs to spaces

    -- Search
    hlsearch = true,            -- Highlight all matches on previous search pattern
    ignorecase = true,          -- Ignore case in search patterns
}

for item, value in pairs(options) do
    vim.opt[item] = value
end
