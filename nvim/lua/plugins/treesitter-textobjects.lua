local textObj = require("core.utils").extraTextobjMaps
--------------------------------------------------------------------------------

return { -- treesitter-based textobjs
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd          = { -- commands need to be defined, since used in various utility functions
                "TSTextobjectSelect",
                "TSTextobjectSwapNext",
                "TSTextobjectSwapPrevious",
                "TSTextobjectGotoNextStart",
                "TSTextobjectGotoPreviousStart",
        },
        keys         = {
                ---[[ COMMENT OPERATIONS
                { -- COMMENT SINGLE
                        "q",
                        function() vim.cmd.TSTextobjectSelect("@comment.outer") end,
                        mode = "o", -- only operator-pending to not conflict with selection-commenting
                        desc = "󰆈 Single Comment",
                },
                { -- COMMENT STICKY DELETE
                        "dq",
                        function()
                                local prevCursor = vim.api.nvim_win_get_cursor(0)
                                vim.cmd.TSTextobjectSelect("@comment.outer")
                                vim.cmd.normal{ "d", bang = true }
                                vim.cmd.normal("zz")
                                vim.api.nvim_win_set_cursor(0, prevCursor)
                        end,
                        desc = "󰆈 Sticky Delete Comment",
                },
                { -- COMMENT CHANGE
                        "cq",
                        function()
                                vim.cmd.TSTextobjectSelect("@comment.outer")
                                vim.cmd.normal{ "d", bang = true }
                                vim.cmd.normal("zz")
                                local comStr = vim.trim{ vim.bo.commentstring:format("") }
                                local line   = vim.api.nvim_get_current_line():gsub("%s+$", "")
                                vim.api.nvim_set_current_line(line .. " " .. comStr .. " ")
                                vim.cmd.startinsert{ bang = true }
                        end,
                        desc = "󰆈 Change Comment",
                },
                --]]

                ---[[ MOVE & SWAP
                { -- COMMENT PREV
                        "<A-Q>",
                        "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        " Goto prev comment",
                },
                { -- COMMENT NEXT
                        "<a-q>",
                        "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        " Goto next comment",
                },
                { -- FUNCTION PREV
                        "<A-F>",
                        "<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        " Goto prev function",
                },
                { -- FUNCTION NEXT
                        "<A-f>",
                        "<cmd>TSTextobjectGotoNextStart @function.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        " Goto next function",
                },
                { -- CONDITION PREV
                        "<A-O>",
                        "<cmd>TSTextobjectGotoPreviousStart @conditional.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󱕆 Goto prev condition",
                },
                { -- CONDITION NEXT
                        "<A-o>",
                        "<cmd>TSTextobjectGotoNextStart @conditional.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󱕆 Goto next condition",
                },
                { -- CALL PREV
                        "<A-C>",
                        "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰡱 Goto prev call",
                },
                { -- CALL NEXT
                        "<A-c>",
                        "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰡱 Goto next call",
                },
                { -- LOOP PREV
                        "<A-U>",
                        "<cmd>TSTextobjectGotoPreviousStart @loop.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto prev loop",
                },
                { -- LOOP NEXT
                        "<A-u>",
                        "<cmd>TSTextobjectGotoNextStart @loop.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto next loop",
                },
                { -- ASSIGNMENT PREV
                        "<A-S>",
                        "<cmd>TSTextobjectGotoPreviousStart @assignment.lhs<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto prev assignment",
                },
                { -- ASSIGNMENT NEXT
                        "<A-s>",
                        "<cmd>TSTextobjectGotoNextStart @assignment.lhs<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto next assignment",
                },
                { -- VALUE PREV
                        "<A-V>",
                        "<cmd>TSTextobjectGotoPreviousStart @assignment.rhs<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto prev value",
                },
                { -- VALUE NEXT
                        "<A-v>",
                        "<cmd>TSTextobjectGotoNextStart @assignment.rhs<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto next value",
                },
                { -- TYPE PREV
                        "<A-T>",
                        "<cmd>TSTextobjectGotoPreviousStart @assignment.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto prev type",
                },
                { -- TYPE NEXT
                        "<A-t>",
                        "<cmd>TSTextobjectGotoNextStart @assignment.outer<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰛤 Goto next type",
                },
                { -- PARAMETER PREV
                        "<A-A>",
                        "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰏪 Goto prev parameter",
                },
                { -- PARAMETER NEXT
                        "<A-a>",
                        "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰏪 Goto next parameter",
                },
                { -- PARAMETER PREV SWAP
                        "<A-{>",
                        "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰏪 Swap prev parameter",
                },
                { -- PARAMETER NEXT SWAP
                        "<A-}>",
                        "<cmd>TSTextobjectSwapNext @parameter.inner<CR>zz",
                        mode = { "n", "x", "o" },
                        desc =
                        "󰏪 Swap next parameter",
                },
                --]]

                ---[[ TEXT OBJECTS
                { -- RETURN INNER
                        "a<CR>",
                        function()
                                vim.cmd.TSTextobjectSelect("@return.outer")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = "↩ outer return",
                },
                { -- RETURN INNER
                        "<CR>",
                        function()
                                vim.cmd.TSTextobjectSelect("@return.inner")
                                vim.cmd.normal("zz")
                        end,
                        mode = "o",
                        desc = "↩ inner return",
                },
                { -- REGEX OUTER
                        "a/",
                        function()
                                vim.cmd.TSTextobjectSelect("@regex.outer")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = " outer regex",
                },
                { -- REGEX INNER
                        "i/",
                        function()
                                vim.cmd.TSTextobjectSelect("@regex.inner")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = "󰛤 inner regex",
                },
                { -- FUNCTION OUTER
                        "a" .. textObj.func,
                        function()
                                vim.cmd.TSTextobjectSelect("@function.outer")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = " outer function",
                },
                { -- FUNCTION INNER
                        "i" .. textObj.func,
                        function()
                                vim.cmd.TSTextobjectSelect("@function.inner")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = " inner function",
                },
                { -- CONDITION OUTER
                        "a" .. textObj.condition,
                        function()
                                vim.cmd.TSTextobjectSelect("@condition.outer")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = "󱕆 outer condition",
                },
                { -- CONDITION INNER
                        "i" .. textObj.condition,
                        function()
                                vim.cmd.TSTextobjectSelect("@condition.inner")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = "󱕆 inner condition",
                },
                { -- CALL OUTER
                        "a" .. textObj.call,
                        function()
                                vim.cmd.TSTextobjectSelect("@call.outer")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = "󰡱 outer call",
                },
                { -- CALL INNER
                        "i" .. textObj.call,
                        function()
                                vim.cmd.TSTextobjectSelect("@call.inner")
                                vim.cmd.normal("zz")
                        end,
                        mode = { "x", "o" },
                        desc = "󰡱 inner call",
                },
                --]]
        },
}
