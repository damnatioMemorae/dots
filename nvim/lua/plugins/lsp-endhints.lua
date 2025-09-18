return {
        "chrisgrieser/nvim-lsp-endhints",
        keys  = {
                { "<leader>oh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "󰑀 Endhints" },
                { "<leader>oH", function() require("lsp-endhints").toggle() end, desc = "󰑀 Endhints" },
        },
        opts  = {
                icons = {
                        type      = "󰜁 ",
                        parameter = "󰏪 ",
                        offspec   = " ", -- hint kind not defined in official LSP spec
                        unknown   = "? ", -- hint kind is nil
                },
                label = { sameKindSeparator = " " },
        },
}
