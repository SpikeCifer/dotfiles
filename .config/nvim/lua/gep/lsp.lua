local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        {"j-hui/fidget.nvim", opts = {}},
        {"folke/neodev.nvim", opts = {}},

        {
            "ray-x/lsp_signature.nvim",
            event = "VeryLazy",
            opts = {},
            config = function(_, opts) require "lsp_signature".setup(opts) end
        },
    },
}

M.config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("gep-lsp", {clear = true}),
        callback = function(event)
            local map = function(keys, func, desc)
                vim.keymap.set("n", keys, func,
                    { buffer = event.buf, desc = "LSP: " .. desc })
            end
            map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            map("K", vim.lsp.buf.hover, "Hover Documentation")
        end
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities,
        require("cmp_nvim_lsp").default_capabilities())

    local servers = {
        clangd = {},
        gopls = {},
        pyright = {},
        lua_ls = {
            settings = {
                Lua = { completion = { callSnippet = "Replace"}},
            }
        }
    },

    require("mason").setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    require("mason-tool-installer").setup { ensure_installed = ensure_installed}

    require("mason-lspconfig").setup {
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend("force", {},
                    capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end,
        },
    }
end

return M
