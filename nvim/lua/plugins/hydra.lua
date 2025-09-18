local config = {
        invoke_on_body = true,
        on_key         = function()
                vim.wait(0, function() vim.cmd"redraw" end, 30, false)
                vim.cmd("norm zz")
        end,
        color          = "pink",
}

local opts   = {
        silent = true,
        nowait = true,
        mode   = { "n", "x" },
}

local fold   = {

        { -- L1
                "1",
                function()
                        require("ufo").closeFoldsWith(1)
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- L2
                "2",
                function()
                        require("ufo").closeFoldsWith(2)
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- L3
                "3",
                function()
                        require("ufo").closeFoldsWith(3)
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- L4
                "4",
                function()
                        require("ufo").closeFoldsWith(4)
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- L5
                "5",
                function()
                        require("ufo").closeFoldsWith(5)
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- CLOSE ALL
                "H",
                function()
                        require("ufo").closeAllFolds()
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- OPEN ALL
                "L",
                function()
                        require("ufo").openAllFolds()
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { "h", "zczz", opts },
        { "l", "zozz", opts },
        { "j", "zjzz", opts },
        { -- GOTO PREV
                "k",
                function()
                        require("ufo").goPreviousStartFold()
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { "J",     "zOzz", opts },
        { -- PREVIEW
                "K",
                function()
                        local winid = require("ufo").peekFoldedLinesUnderCursor()
                        if not winid then vim.lsp.buf.hover() end
                end,
                opts,
        },

        { -- CURSOR PREVIOUS
                "<C-o>",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end,
                opts,
        },

        { "<Esc>", nil,    { exit = true, desc = false } },
}

local window = {

        { -- SHIFT LEFT
                "<C-h>", "<cmd>WinShift left<CR>", opts,
        },
        { -- SHIFT DOWN
                "<C-j>", "<cmd>WinShift down<CR>", opts,
        },
        { -- SHIFT UP
                "<C-k>", "<cmd>WinShift up<CR>", opts,
        },
        { -- SHIFT RIGHT
                "<C-l>", "<cmd>WinShift right<CR>", opts,
        },
        { -- SHIFT LEFT  FAR
                "<S-H>", "<cmd>WinShift far_left<CR>", opts,
        },
        { -- SHIFT DOWN  FAR
                "<S-J>", "<cmd>WinShift far_down<CR>", opts,
        },
        { -- SHIFT UP    FAR
                "<S-K>", "<cmd>WinShift far_up<CR>", opts,
        },
        { -- SHIFT RIGHT FAR
                "<S-L>", "<cmd>WinShift far_right<CR>", opts,
        },

        { -- LEFT
                "h",
                function()
                        require("smart-splits").move_cursor_left()
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- DOWN
                "j",
                function()
                        require("smart-splits").move_cursor_down()
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- UP
                "k",
                function()
                        require("smart-splits").move_cursor_up()
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- RIGHT
                "l",
                function()
                        require("smart-splits").move_cursor_right()
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- PREVIOUS
                "u",
                function()
                        require("smart-splits").move_cursor_previous()
                        vim.cmd("norm zz")
                end,
                opts,
        },

        { -- LEFT
                "<A-h>",
                function() require("smart-splits").resize_left() end, opts,
        },
        { -- DOWN
                "<A-j>",
                function() require("smart-splits").resize_down() end, opts,
        },
        { -- UP
                "<A-k>",
                function() require("smart-splits").resize_up() end, opts,
        },
        { -- RIGHT
                "<A-l>",
                function() require("smart-splits").resize_right() end, opts,
        },

        { -- VERTICAL
                "v", "<C-W>vzz", opts,
        },
        { -- HORIZONTAL
                "s", "<C-W>szz", opts,
        },
        { -- DELETE
                "d", "<C-W>czz", opts,
        },

        { "<Esc>", nil, { exit = true, desc = false } },
}

local tree   = {

        { -- ARG  INNER PREV
                "<A-S-P>",
                "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>zz",
                opts,
        },
        { -- ARG  INNER NEXT
                "<A-p>",
                "<cmd>TSTextobjectSwapNext @parameter.inner<CR>zz",
                opts,
        },

        { -- FUNC OUTER PREV
                "F",
                "<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>zz",
                opts,
        },
        { -- FUNC OUTER NEXT
                "f",
                "<cmd>TSTextobjectGotoNextStart @function.outer<CR>zz",
                opts,
        },
        { -- FUNC INNER PREV
                "<C-S-F>",
                "<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>zz",
                opts,
        },
        { -- FUNC INNER NEXT
                "<C-f>",
                "<cmd>TSTextobjectGotoNextStart @function.inner<CR>zz",
                opts,
        },

        { -- CALL OUTER PREV
                "R",
                "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                opts,
        },
        { -- CALL OUTER NEXT
                "r",
                "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                opts,
        },
        { -- CALL INNER PREV
                "<C-S-R>",
                "<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>zz",
                opts,
        },
        { -- CALL INNER NEXT
                "<C-r>",
                "<cmd>TSTextobjectGotoNextStart @call.inner<CR>zz",
                opts,
        },

        { -- COND OUTER PREV
                "M",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.outer<CR>zz",
                opts,
        },
        { -- COND OUTER NEXT
                "m",
                "<cmd>TSTextobjectGotoNextStart @conditional.outer<CR>zz",
                opts,
        },
        { -- COND INNER PREV
                "<C-S-M>",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.inner<CR>zz",
                opts,
        },
        { -- COND INNER NEXT
                "<C-m>",
                "<cmd>TSTextobjectGotoNextStart @conditional.inner<CR>zz",
                opts,
        },

        { -- LOOP OUTER PREV
                "O",
                "<cmd>TSTextobjectGotoPreviousStart @loop.outer<CR>zz",
                opts,
        },
        { -- LOOP OUTER NEXT
                "o",
                "<cmd>TSTextobjectGotoNextStart @loop.outer<CR>zz",
                opts,
        },
        { -- LOOP INNER PREV
                "<C-S-O>",
                "<cmd>TSTextobjectGotoPreviousStart @loop.inner<CR>zz",
                opts,
        },
        { -- LOOP INNER NEXT
                "<C-o>",
                "<cmd>TSTextobjectGotoNextStart @loop.inner<CR>zz",
                opts,
        },

        { -- VAR  PREV
                "A",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.lhs<CR>zz",
                opts,
        },
        { -- VAR  NEXT
                "a",
                "<cmd>TSTextobjectGotoNextStart @assignment.lhs<CR>zz",
                opts,
        },
        { -- VAL  PREV
                "<C-S-A>",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.rhs<CR>zz",
                opts,
        },
        { -- VAL  NEXT
                "<C-a>",
                "<cmd>TSTextobjectGotoNextStart @assignment.rhs<CR>zz",
                opts,
        },
        { -- TYPE PREV
                "X",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.outer<CR>zz",
                opts,
        },
        { -- TYPE NEXT
                "x",
                "<cmd>TSTextobjectGotoNextStart @assignment.outer<CR>zz",
                opts,
        },

        { -- ARG  INNER PREV
                "P",
                "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>zz",
                opts,
        },
        { -- ARG  INNER NEXT
                "p",
                "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>zz",
                opts,
        },

        { -- COMM OUTER PREV
                "Q",
                "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>zz",
                opts,
        },
        { -- COMM OUTER NEXT
                "q",
                "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>zz",
                opts,
        },

        { -- NODE END
                "N",
                "<cmd>TSTextobjectGotoPreviousStart @_end<CR>zz",
                opts,
        },
        { -- NODE START
                "n",
                "<cmd>TSTextobjectGotoNextStart @_start<CR>zz",
                opts,
        },

        { -- STAT OUTER PREV
                "S",
                "<cmd>TSTextobjectGotoPreviousStart @statement.outer<CR>zz",
                opts,
        },
        { -- STAT OUTER PREV
                "s",
                "<cmd>TSTextobjectGotoNextStart @statement.outer<CR>zz",
                opts,
        },

        { -- RTRN OUTER PREV
                "<S-CR>",
                "<cmd>TSTextobjectGotoPreviousStart @return.outer<CR>zz",
                opts,
        },
        { -- RTRN OUTER NEXT
                "<CR>",
                "<cmd>TSTextobjectGotoNextStart @return.outer<CR>zz",
                opts,
        },

        { "<Esc>", nil, { exit = true, desc = false } },
}

local lsp    = {

        { -- DIAG NEXT
                "d",
                function()
                        vim.diagnostic.goto_next({ float = false })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- DIAG PREV
                "D",
                function()
                        vim.diagnostic.goto_prev({ float = false })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- ERROR  NEXT
                "e",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- ERROR  PREV
                "E",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- WARN  NEXT
                "w",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- WARN  PREV
                "W",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- INFO  NEXT
                "i",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- INFO  PREV
                "I",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- HINT  NEXT
                "h",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- HINT  PREV
                "H",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end,
                opts,
        },

        { "<Esc>", nil, { exit = true, desc = false } },
}

local nav    = {

        { -- ARG  INNER PREV
                "<A-S-P>",
                "<cmd>TSTextobjectSwapPrevious @parameter.inner<CR>zz",
                opts,
        },
        { -- ARG  INNER NEXT
                "<A-p>",
                "<cmd>TSTextobjectSwapNext @parameter.inner<CR>zz",
                opts,
        },

        { -- FUNC OUTER PREV
                "F",
                "<cmd>TSTextobjectGotoPreviousStart @function.outer<CR>zz",
                opts,
        },
        { -- FUNC OUTER NEXT
                "f",
                "<cmd>TSTextobjectGotoNextStart @function.outer<CR>zz",
                opts,
        },
        { -- FUNC INNER PREV
                "<C-S-F>",
                "<cmd>TSTextobjectGotoPreviousStart @function.inner<CR>zz",
                opts,
        },
        { -- FUNC INNER NEXT
                "<C-f>",
                "<cmd>TSTextobjectGotoNextStart @function.inner<CR>zz",
                opts,
        },

        { -- CALL OUTER PREV
                "R",
                "<cmd>TSTextobjectGotoPreviousStart @call.outer<CR>zz",
                opts,
        },
        { -- CALL OUTER NEXT
                "r",
                "<cmd>TSTextobjectGotoNextStart @call.outer<CR>zz",
                opts,
        },
        { -- CALL INNER PREV
                "<C-S-R>",
                "<cmd>TSTextobjectGotoPreviousStart @call.inner<CR>zz",
                opts,
        },
        { -- CALL INNER NEXT
                "<C-r>",
                "<cmd>TSTextobjectGotoNextStart @call.inner<CR>zz",
                opts,
        },

        { -- COND OUTER PREV
                "M",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.outer<CR>zz",
                opts,
        },
        { -- COND OUTER NEXT
                "m",
                "<cmd>TSTextobjectGotoNextStart @conditional.outer<CR>zz",
                opts,
        },
        { -- COND INNER PREV
                "<C-S-M>",
                "<cmd>TSTextobjectGotoPreviousStart @conditional.inner<CR>zz",
                opts,
        },
        { -- COND INNER NEXT
                "<C-m>",
                "<cmd>TSTextobjectGotoNextStart @conditional.inner<CR>zz",
                opts,
        },

        { -- LOOP OUTER PREV
                "O",
                "<cmd>TSTextobjectGotoPreviousStart @loop.outer<CR>zz",
                opts,
        },
        { -- LOOP OUTER NEXT
                "o",
                "<cmd>TSTextobjectGotoNextStart @loop.outer<CR>zz",
                opts,
        },
        { -- LOOP INNER PREV
                "<C-S-O>",
                "<cmd>TSTextobjectGotoPreviousStart @loop.inner<CR>zz",
                opts,
        },
        { -- LOOP INNER NEXT
                "<C-o>",
                "<cmd>TSTextobjectGotoNextStart @loop.inner<CR>zz",
                opts,
        },

        { -- VAR  PREV
                "A",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.lhs<CR>zz",
                opts,
        },
        { -- VAR  NEXT
                "a",
                "<cmd>TSTextobjectGotoNextStart @assignment.lhs<CR>zz",
                opts,
        },
        { -- VAL  PREV
                "<C-S-A>",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.rhs<CR>zz",
                opts,
        },
        { -- VAL  NEXT
                "<C-a>",
                "<cmd>TSTextobjectGotoNextStart @assignment.rhs<CR>zz",
                opts,
        },
        { -- TYPE PREV
                "X",
                "<cmd>TSTextobjectGotoPreviousStart @assignment.outer<CR>zz",
                opts,
        },
        { -- TYPE NEXT
                "x",
                "<cmd>TSTextobjectGotoNextStart @assignment.outer<CR>zz",
                opts,
        },

        { -- ARG  INNER PREV
                "P",
                "<cmd>TSTextobjectGotoPreviousStart @parameter.inner<CR>zz",
                opts,
        },
        { -- ARG  INNER NEXT
                "p",
                "<cmd>TSTextobjectGotoNextStart @parameter.inner<CR>zz",
                opts,
        },

        { -- COMM OUTER PREV
                "Q",
                "<cmd>TSTextobjectGotoPreviousStart @comment.outer<CR>zz",
                opts,
        },
        { -- COMM OUTER NEXT
                "q",
                "<cmd>TSTextobjectGotoNextStart @comment.outer<CR>zz",
                opts,
        },

        { -- NODE END
                "N",
                "<cmd>TSTextobjectGotoPreviousStart @_end<CR>zz",
                opts,
        },
        { -- NODE START
                "n",
                "<cmd>TSTextobjectGotoNextStart @_start<CR>zz",
                opts,
        },

        { -- STAT OUTER PREV
                "S",
                "<cmd>TSTextobjectGotoPreviousStart @statement.outer<CR>zz",
                opts,
        },
        { -- STAT OUTER PREV
                "s",
                "<cmd>TSTextobjectGotoNextStart @statement.outer<CR>zz",
                opts,
        },

        { -- RTRN OUTER PREV
                "<S-CR>",
                "<cmd>TSTextobjectGotoPreviousStart @return.outer<CR>zz",
                opts,
        },
        { -- RTRN OUTER NEXT
                "<CR>",
                "<cmd>TSTextobjectGotoNextStart @return.outer<CR>zz",
                opts,
        },

        { -- DIAG PREV
                "<C-S-D>",
                function()
                        vim.diagnostic.goto_prev({ float = false })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- DIAG NEXT
                "<C-d>",
                function()
                        vim.diagnostic.goto_next({ float = false })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- ERROR  PREV
                "<C-S-E>",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- ERROR  NEXT
                "<C-e>",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.ERROR })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- WARN  PREV
                "<C-S-W>",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- WARN  NEXT
                "<C-w>",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.WARN })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- INFO  PREV
                "<C-S-I>",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- INFO  NEXT
                "<C-i>",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.INFO })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- HINT  PREV
                "<C-S-H>",
                function()
                        vim.diagnostic.goto_prev({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end,
                opts,
        },
        { -- HINT  NEXT
                "<C-h>",
                function()
                        vim.diagnostic.goto_next({ float = false, severity = vim.diagnostic.severity.HINT })
                        vim.cmd("norm zz")
                end,
                opts,
        },

        -- { "h", "zczz", opts },
        -- { "l", "zozz", opts },
        -- { "j", "zjzz", opts },
        -- {
        --         "k",
        --         function()
        --                 require("ufo").goPreviousStartFold()
        --                 vim.cmd("norm zz")
        --         end,
        --         opts
        -- },

        { "<Esc>", nil, { exit = true, desc = false } },

}

return {
        "anuvyklack/hydra.nvim",
        enabled = false,
        lazy    = false,
        event   = "VeryLazy",
        config  = function()
                local hydra = require("hydra")

                hydra({ -- FOLDMODE
                        name   = "FOLDMODE",
                        config = config,
                        mode   = { "n", "v" },
                        body   = "''",
                        color  = "pink",
                        heads  = fold,
                })
                hydra({ -- WINMODE
                        name   = "winmode",
                        config = config,
                        mode   = { "n", "v" },
                        body   = '""',
                        color  = "pink",
                        heads  = window,
                })
                hydra({ -- TREEMODE
                        name   = "TREEMODE",
                        config = config,
                        mode   = { "n", "v" },
                        body   = ";;",
                        color  = "pink",
                        heads  = tree,
                })
                hydra({ -- LSPMODE
                        name   = "LSPMODE",
                        config = config,
                        mode   = { "n", "v" },
                        body   = "[[",
                        color  = "pink",
                        heads  = lsp,
                })
                hydra({ -- NAVMODE
                        name   = "NAVMODE",
                        config = config,
                        mode   = { "n", "v" },
                        body   = ",,",
                        color  = "pink",
                        heads  = nav,
                })
        end,
}
