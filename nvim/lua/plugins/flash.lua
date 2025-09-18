return {
        "folke/flash.nvim",
        event  = "VeryLazy",
        keys   = {
                {
                        "s",
                        mode = { "n", "x", "o" },
                        function() require("flash").jump() end,
                        desc = "Flash",
                },
                {
                        "r",
                        mode = "o",
                        function() require("flash").treesitter_search() end,
                        desc = "Treesitter Search",
                },
                {
                        "R",
                        mode = "o",
                        function() require("flash").remote() end,
                        desc = "Remote Flash",
                },
        },
        opts   = {
                jump   = { nohlsearch = true },
                prompt = {
                        win_config = {
                                border = "single",
                                -- Place the prompt above the statusline.
                                row    = -3,
                        },
                },
                search = {
                        enabled = false,
                        exclude = {
                                "flash_prompt",
                                "qf",
                                "notify",
                                "cmp_menu",
                                "noice",
                                "flash_prompt",
                                function(win)
                                        -- Floating windows from bqf.
                                        if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):match "BqfPreview" then
                                                return true
                                        end

                                        -- Non-focusable windows.
                                        return not vim.api.nvim_win_get_config(win).focusable
                                end,
                        },
                },
                modes  = {
                        char   = { enabled = false },
                        search = { enabled = true },
                },
        },
        config = function(_, opts)
                require("flash").setup(opts)
        end
}
