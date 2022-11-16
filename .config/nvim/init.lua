-- Disable netrw here due to race conditions
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require "spiccy.options"    -- General Settings
require "spiccy.plugins"    -- Plugins with Packer Manager
require "spiccy.colors"     -- Themes
require "spiccy.tree"       -- A Better File Explorer
require "spiccy.lsp"        -- The LSP configurations
require "spiccy.complete"   -- Completion Suggestions
require "spiccy.treesitter" -- Treesitter
