-- icons = require("core.icons").diagnostics
icons = require("core.icons").diagnostics.HINT

return {
        "rachartier/tiny-inline-diagnostic.nvim",
        event    = "VeryLazy",
        priority = 1000,
        opts     = {
                signs   = {
                        left         = "",
                        right        = "",
                        diag         = icons,
                        arrow        = "",
                        up_arrow     = " ",
                        vertical     = " │",
                        vertical_end = " └",
                },
                blend   = { factor = 0.1 },
                hi      = { error = "DiagnosticError", warn = "DiagnosticWarn", info = "DiagnosticInfo", hint = "DiagnosticHint", arrow = "NonText" },
                options = {
                        show_source                  = false,
                        throttle                     = 20,
                        softwrap                     = 30,
                        multiple_diag_under_cursor   = true,
                        multilines                   = true,
                        show_all_diags_on_cursorline = true,
                        enable_on_insert             = false,
                        enable_on_select             = true,
                        overwrite_events             = nil,
                        overflow                     = { mode = "wrap" },
                        break_line                   = { enabled = false, after = 30 },
                        virt_texts                   = { priority = 99 },
                        -- format                       = function(diagnostic)
                        --         local special_sources = {
                        --                 ["Lua Diagnostics."]  = "lua",
                        --                 ["Lua Syntax Check."] = "lua",
                        --         }
                        --
                        --         local message         = icons[vim.diagnostic.severity[diagnostic.severity]]
                        --         if diagnostic.source then
                        --                 -- vim.api.nvim_create_autocmd("CursorHold", {
                        --                 --         callback = function()
                        --                 --                 vim.diagnostic.open_float(nil, { focusable = false })
                        --                 --         end
                        --                 -- })
                        --                 message = string.format("%s %s", message,
                        --                         special_sources[diagnostic.source] or diagnostic.source)
                        --         end
                        --         if diagnostic.code then
                        --                 message = string.format("%s [%s]", message, diagnostic.code)
                        --         end
                        --
                        --         return message
                        -- end,
                },
        },
}
