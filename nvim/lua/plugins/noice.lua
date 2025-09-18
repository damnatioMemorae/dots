return {
        "folke/noice.nvim",
        enabled = false,
        event   = "VeryLazy",
        config  = function()
                require("noice").setup({
                        routes    = { { opts = { skip = true }, filter = { event = "msg_show", kind = "search_count" } } },
                        notify    = { enabled = false },
                        messages  = { enabled = true },
                        popupmenu = { enabled = false },
                        presets   = {
                                inc_rename     = true,
                                lsp_doc_border = true,
                        },
                        lsp       = {
                                progress = { enabled = false },
                                override = {
                                        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                                        ["vim.lsp.util.stylize_markdown"]                = false,
                                        ["cmp.entry.get_documentation"]                  = false,
                                },
                        },
                        views     = {
                                cmdline_popup = {
                                        border         = { style = "none", padding = { 1, 1 } },
                                        position       = { row = 6, col = "50%" },
                                        filter_options = {},
                                },
                        },
                        signature = { enabled = false },
                        cmdline   = {
                                enabled = true,
                                view    = "cmdline",
                                -- format  = {
                                --         cmdline     = { pattern = "^:", icon = ">", lang = "vim" },
                                --         search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                                --         search_up   = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                                --         filter      = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                                --         lua         = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                                --         help        = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                                --         input       = { view = "cmdline_input", icon = "󰥻 " },
                                -- },
                        },
                })
        end,
}
