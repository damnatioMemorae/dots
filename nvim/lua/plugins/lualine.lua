return {
        "nvim-lualine/lualine.nvim",
        lazy         = false,
        dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
        config       = function()
                local colors = {
                        text     = "#cdd6f4",
                        surface0 = "#45475a",
                        base     = "#1e1e2e",
                        mantle   = "#181825",
                        crust    = "#0e0e16",
                        -- crust    = "#000000",
                        red      = "#f38ba8",
                        green    = "#a6e3a1",
                        yellow   = "#f9e2af",
                }
                local theme  = {
                        normal   = {
                                a = { fg = colors.crust, bg = colors.text, bold = true },
                                b = { fg = colors.text, bg = colors.crust },
                                c = { fg = colors.surface0, bg = colors.crust },
                                x = { fg = colors.text, bg = colors.crust },
                                y = { fg = colors.text, bg = colors.crust },
                                z = { fg = colors.text, bg = colors.crust },
                        },

                        insert   = { a = { fg = colors.crust, bg = colors.text, bold = true } },
                        visual   = { a = { fg = colors.crust, bg = colors.text, bold = true } },
                        replace  = { a = { fg = colors.crust, bg = colors.text, bold = true } },

                        inactive = {
                                a = { fg = colors.surface0, bg = colors.crust },
                                b = { fg = colors.text, bg = colors.crust },
                                c = { fg = colors.text, bg = colors.crust },
                                x = { fg = colors.text, bg = colors.crust },
                                y = { fg = colors.text, bg = colors.crust },
                                z = { fg = colors.text, bg = colors.crust },
                        },
                }
                require("lualine").setup({
                        disabled_filetypes = {
                                "neo-tree",
                        },
                        options            = {
                                theme                = theme,
                                section_separators   = "",
                                component_separators = "",
                        },
                        sections           = {
                                lualine_a = {
                                        {
                                                "mode",
                                                fmt = function(str) return str:sub(1, 1) end,
                                        },
                                },
                                lualine_b = {
                                        "branch",
                                        {
                                                "diff",
                                                colored    = true,
                                                diff_color = {
                                                        added    = "String",
                                                        modified = "GitSignsAdd",
                                                        removed  = "GitSignsDelete",
                                                },
                                                symbols    = { added = "+", modified = "~", removed = "-" },
                                                source     = nil,
                                        },
                                },
                                lualine_c = {
                                        {
                                                "filename",
                                                file_status = false,
                                        },
                                },
                                lualine_x = {},
                                lualine_y = {
                                        {
                                                function()
                                                        local saved = vim.bo.modified and "*" or ""
                                                        return saved
                                                end,
                                        },
                                },
                                lualine_z = {
                                        {
                                                "diagnostics",
                                                sources           = { "nvim_diagnostic", "coc" },
                                                sections          = { "error", "warn", "info" },
                                                diagnostics_color = {
                                                        error = "DiagnosticError",
                                                        warn  = "DiagnosticWarn",
                                                        info  = "DiagnosticInfo",
                                                        hint  = "DiagnosticHint",
                                                },
                                                symbols           = { error = "", warn = " ", info = " ", hint = " " },
                                                colored           = true,
                                                update_in_insert  = true,
                                                always_visible    = true,
                                        },
                                },
                        },
                        inactive_sections  = {
                                lualine_a = {
                                        { "filename", file_status = true },
                                },
                                lualine_b = {
                                },
                                lualine_c = {
                                },
                                lualine_x = {
                                },
                                lualine_y = {
                                },
                                lualine_z = {
                                },
                        },
                        extensions         = {
                                "neo-tree",
                        },
                })
        end,
}
