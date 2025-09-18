return {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        event        = "LspAttach",
        keys         = {
                { "<leader>if", vim.cmd.UfoInspect, vim.cmd("norm zz"), desc = " Fold info" },
                { "z1", function() require("ufo").closeFoldsWith(1) vim.cmd.normal("zz") end, desc = "󱃄 Close L1 folds" },
                { "z2", function() require("ufo").closeFoldsWith(2) vim.cmd.normal("zz") end, desc = "󱃄 Close L2 folds" },
                { "z3", function() require("ufo").closeFoldsWith(3) vim.cmd.normal("zz") end, desc = "󱃄 Close L3 folds" },
                { "z4", function() require("ufo").closeFoldsWith(4) vim.cmd.normal("zz") end, desc = "󱃄 Close L4 folds" },
                { "z5", function() require("ufo").closeFoldsWith(5) vim.cmd.normal("zz") end, desc = "󱃄 Close L5 folds" },
                { -- OPEN
                        "zL",
                        function()
                                require("ufo").openFoldsExceptKinds { "comment", "imports" }
                                vim.cmd.normal("zz")
                        end,
                        desc = "󱃄 Open regular folds",
                },
                { -- CLOSE
                        "zH",
                        function()
                                -- require("ufo").closeAllFolds()
                                require("ufo").openFoldsExceptKinds { "comment", "imports", "region" }
                                vim.cmd.normal("zz")
                        end,
                        desc = "󱃄 Close all folds",
                },
                { -- CLOSE ALL
                        "zm",
                        function()
                                require("ufo").closeAllFolds()
                                vim.cmd.normal("zz")
                        end,
                        desc = "󱃄 Close all folds",
                },
                { -- FOLD PREVIEW
                        "zK",
                        function()
                                local winid = require("ufo").peekFoldedLinesUnderCursor()
                                if not winid then vim.lsp.buf.hover() end
                                vim.cmd.normal("zz")
                        end,
                        desc = "󱃄 Close all folds"
                },
                { -- GOTO PREVIOUS FOLD START
                        "<A-Z>",
                        function()
                                require("ufo").goPreviousStartFold()
                                vim.cmd.normal("zz")
                        end,
                        desc = "󱃄 Close all folds",
                },
                { -- GOTO PREVIOUS FOLD START
                        "zk",
                        function()
                                require("ufo").goPreviousStartFold()
                                vim.cmd.normal("zz")
                        end,
                        desc = "󱃄 Close all folds",
                },
        },
        init         = function()
                vim.opt.foldlevel      = 99
                vim.opt.foldlevelstart = 99
        end,
        opts         = {
                -- when opening the buffer, close these fold kinds
                close_fold_kinds_for_ft = {
                        cpp      = { "region", "comment" },
                        c        = { "region", "comment" },
                        default  = { "imports", "comment" },
                        json     = { "array" },
                        lua      = { "region" },
                        markdown = {}, -- avoid everything becoming folded
                        python   = {},
                        sh       = {},
                        toml     = {},
                        zsh      = { "if_statement", "for_statement", "function_definition" },
                        -- use `:UfoInspect` to get see available fold kinds
                },
                open_fold_hl_timeout    = 400,
                preview                 = {
                        win_config = {
                                border       = "none",
                                winblend     = vim.g.winblend,
                                winhighlight = "NormalFloat:NormalFloat",
                        }
                },
                provider_selector       = function(_bufnr, ft, _buftype)
                        -- ufo accepts only two kinds as priority, see https://github.com/kevinhwang91/nvim-ufo/issues/256
                        local lspWithOutFolding = { "markdown", "zsh", "bash", "css", "json" }
                        if vim.tbl_contains(lspWithOutFolding, ft) then
                                return { "treesitter", "indent" }
                        end
                        return { "lsp", "indent" }
                end,
                -- show folds with number of folded lines instead of just the icon
                fold_virt_text_handler  = function(virtText, lnum, endLnum, width, truncate)
                        local hlgroup     = "FoldMark"
                        local icon        = "󰘖"
                        local newVirtText = {}
                        local suffix      = ("%s  %d "):format(icon, endLnum - lnum)
                        local sufWidth    = vim.fn.strdisplaywidth(suffix)
                        local targetWidth = width - sufWidth
                        local curWidth    = 0
                        for _, chunk in ipairs(virtText) do
                                local chunkText  = chunk[1]
                                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                                if targetWidth > curWidth + chunkWidth then
                                        table.insert(newVirtText, chunk)
                                else
                                        chunkText     = truncate(chunkText, targetWidth - curWidth)
                                        local hlGroup = chunk[2]
                                        table.insert(newVirtText, { chunkText, hlGroup })
                                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                                        if curWidth + chunkWidth < targetWidth then
                                                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                                        end
                                        break
                                end
                                curWidth = curWidth + chunkWidth
                        end
                        table.insert(newVirtText, { suffix, hlgroup })
                        return newVirtText
                end,
        },
}
