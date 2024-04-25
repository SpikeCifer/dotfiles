local M = {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",

        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        "onsails/lspkind.nvim"
    },
}

M.config = function()
        local cmp = require "cmp"
        local lspkind = require("lspkind")
        cmp.setup({
            snippet = {
                expand =  function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                    }),
                }),
            },

            completion = { completeopt = "menu,menuone,noinsert"},

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),

                ["<CR>"] = cmp.mapping.confirm { select = true },
            }),

            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                {name = "bbuffer"},
            })
    })
end
return M
