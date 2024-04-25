return {
    "nvim-telescope/telescope.nvim", tag = "0.1.6",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable "make" == 1
            end,
        },
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font }
    },

    config = function()
        require("telescope").setup {
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                }
            }
        }

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local builtin = require "telescope.builtin"
        vim.keymap.set("n", "<leader>ff", builtin.find_files)
        vim.keymap.set("n", "<leader>lg", builtin.live_grep)
        vim.keymap.set("n", "<leader>gf", builtin.git_files)
    end
}
