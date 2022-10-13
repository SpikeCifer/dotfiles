local M = {}

function M.setup()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {"ruby", "go", "java", "rust", "c", "lua"},
        sync_install = false,
        context_commentstring = { enable = true },
        auto_install = true,
        highlight = {enable = true},
    }
end

return M
