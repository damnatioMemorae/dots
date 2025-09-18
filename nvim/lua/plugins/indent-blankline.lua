return {
        "lukas-reineke/indent-blankline.nvim",
        lazy   = false,
        event  = "VeryLazy",
        main   = "ibl",
        keys   = { { "<leader>oi", "<cmd>IBLToggle<CR>", desc = "󰖶 Indent guides", mode = { "n" } } },
        config = function()
                require("ibl").setup({
                        indent     = {
                                tab_char = " ",
                                char     = " "
                        },
                        whitespace = {
                                remove_blankline_trail = true,
                        },
                        scope      = {
                                show_start = true,
                                show_end   = true,
                                char       = require("core.icons").misc.vertical_bar,
                        },
                })
        end,
}
