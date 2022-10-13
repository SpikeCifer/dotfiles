-- Disable netrw here due to race conditions
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


require "spiccy.options"    -- Could have named the file settings, but since vim refers to them as options I kept it options :)
require "spiccy.plugins"    -- Plugins with Packer Manager
require "spiccy.colors"     -- Themes
require "spiccy.tree"       -- A Better File Explorer
require "spiccy.complete"   -- Completion Suggestions
require "spiccy.treesitter" -- Treesitter
