-- Keybinds
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Define required servers
local servers = {
    gopls = {},
    sumneko_lua = {},
    rust_analyzer = {},
    clangd = {},
    clojure_lsp = {},
    jdtls = {}
}

-- The way this works is as follows
-- First you must install the servers via Mason or any other way
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local capabilities = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Jump to Defintion
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Displays hover information about the symbol under the cursor
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- Jump to implementation
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts) -- Selects a code action at the current cursor position
end


-- Then this configures the servers to work on any file that is opened
for server in pairs(servers) do
    require("lspconfig")[server].setup{
        on_attach = capabilities
    }
end

