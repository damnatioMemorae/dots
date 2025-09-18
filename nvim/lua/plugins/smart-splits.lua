return {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
        keys  = {
                { -- MOVE LEFT
                        "<C-h>",
                        function()
                                require("smart-splits").move_cursor_left()
                                vim.cmd.normal("zz")
                        end,
                },
                { -- MOVE DOWN
                        "<C-j>",
                        function()
                                require("smart-splits").move_cursor_down()
                                vim.cmd.normal("zz")
                        end,
                },
                { -- MOVE UP
                        "<C-k>",
                        function()
                                require("smart-splits").move_cursor_up()
                                vim.cmd.normal("zz")
                        end,
                },
                { -- MOVE RIGHT
                        "<C-l>",
                        function()
                                require("smart-splits").move_cursor_right()
                                vim.cmd.normal("zz")
                        end,
                },
                { -- MOVE PREVIOUS
                        "<C-S-o>",
                        function()
                                require("smart-splits").move_cursor_previous()
                                vim.cmd.normal("zz")
                        end,
                },
                { -- RESIZE LEFT
                        "<C-left>",
                        function()
                                require("smart-splits").resize_left()
                        end,
                },
                { -- RESIZE DOWN
                        "<C-down>",
                        function()
                                require("smart-splits").resize_down()
                        end,
                },
                { -- RESIZE UP
                        "<C-up>",
                        function()
                                require("smart-splits").resize_up()
                        end,
                },
                { -- RESIZE RIGHT
                        "<C-right>",
                        function()
                                require("smart-splits").resize_right()
                        end,
                },
        },
}
