return {
        "chrisgrieser/nvim-rip-substitute",
        cmd  = "RipSubstitute",
        keys = {
                {
                        "<leader>fs",
                        function() require("rip-substitute").sub() end,
                        mode = { "n", "x" },
                        desc = " substitute (rip-sub)",
                },
                {
                        "<leader>fS",
                        function() require("rip-substitute").rememberCursorWord() end,
                        desc = " remember cword (rip-sub)",
                },
        },
        opts = {
                popupWin        = {
                        title                   = "",
                        border                  = vim.g.borderStyle,
                        position                = "top",
                        hideSearchReplaceLabels = true,
                        hideKeymapHints         = true,
                        matchCountHlGroup       = "FloatTitle",
                        noMatchHlGroup          = "FloatTitle",
                },
                prefill         = {
                        normal                      = "cursorWord",
                        visual                      = "selectionFirstLine",
                        startInReplaceLineIfPrefill = true,
                        alsoPrefillReplaceLine      = true,
                },
                keymaps         = {
                        insertModeConfirm = "<CR>",
                        abort             = "<Esc>",
                },
                editingBehavior = {
                        autoCaptureGroups = true,
                },
        },
}
