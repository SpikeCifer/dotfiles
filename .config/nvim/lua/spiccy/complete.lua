local status_ok, cmp = pcall(require, "cmp")
if not status_ok then 
    print "Failed to find cmp"
    return 
end

local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then 
    print "Failed to find lspkind"
    return 
end

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        -- TODO: Read the ins-completion help file to learn why you should not
        -- use TAB
    }),

    sources = cmp.config.sources({
        {name = "nvim_lua"},
        {name = "nvim_lsp"},
        {name = "path"},
        {name = "luasnip"},
        {name = "buffer"},
    }),

    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                path = "[path]",
            })
        })
    },

    experimental = {
        ghost_text = true, -- Show full word before fully written
    },
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
