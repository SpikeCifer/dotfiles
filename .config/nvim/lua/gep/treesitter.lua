local TextObjects = { "nvim-treesitter/nvim-treesitter-textobjects", }

TextObjects.config = function ()
    local move = require "nvim-treesitter.textobjects.move" ---@type table<string, fun(...)>
    local configs = require "nvim-treesitter.configs"
    for name, fn in pairs(move) do
        if name:find("goto") == 1 then
            move[name] = function (q, ...)
                if vim.wo.diff then
                    ---@type table<string, string>
                    local config = configs.get_module("textobjects.move")[name]
                    for key, query in pairs(config or {}) do
                        if q == query and key:find("[%]%[][cC]") then
                            vim.cmd("normal!" .. key)
                            return
                        end
                    end
                end
                return fn(q, ...)
            end
        end
    end
end

local Treesitter = {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    dependencies = {
        TextObjects,
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall"}
}

Treesitter.config = function()
    local opts = {
        highlight = { enable = true },
        auto_install = true,
        indent = { enable = true},
        ensure_installed = {"c", "go", "python", "lua"},
        textobjects = {
            select = {
                enable = true,

                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["aI"] = "@block.outer",
                    ["iI"] = "@block.inner",
                }
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>n"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>p"] = "@parameter.inner",
                }
            }
        }
    }

    if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
            if added[lang] then
                return false
            end
            added[lang] = true
            return true
        end, opts.ensure_installed)
    end

    require("nvim-treesitter.configs").setup(opts)
end

return Treesitter
