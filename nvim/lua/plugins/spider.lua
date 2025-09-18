return { -- CamelCase Motion plus
        "chrisgrieser/nvim-spider",
        keys = {
                {
                        "e",
                        "<cmd>lua require('spider').motion('e')<CR>",
                        mode = { "n", "x", "o" },
                        desc = "󱇫 end of subword",
                },
                {
                        "w",
                        "<cmd>lua require('spider').motion('w', {skipInsignificantPunctuation = false})<CR>",
                        mode = { "n", "x", "o" },
                        desc = "󱇫 end of subword",
                },
                {
                        "b",
                        "<cmd>lua require('spider').motion('b')<CR>",
                        mode = { "n", "x" }, -- not `o`, since mapped to inner bracket
                        desc = "󱇫 beginning of subword",
                },
        },
        config = function()
                require("spider").setup({
                        skipInsignificantPunctuation = false,
                })
        end
}
