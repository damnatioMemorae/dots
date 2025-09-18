return {
        "lewis6991/gitsigns.nvim",
        event  = "VeryLazy",
        keys   = {
                -- stylua: ignore start
                { "gh", function() require("gitsigns").nav_hunk("next", { foldopen = true, navigation_message = true }) end, desc = "󰊢 Next Hunk" },
                { "ga", "<cmd>Gitsigns stage_hunk<CR>", desc = "󰊢 Stage Hunk" },
                { "gH", function() require("gitsigns").nav_hunk("prev", { foldopen = true, navigation_message = true }) end, desc = "󰊢 Previous Hunk" },
                { "ga", ":Gitsigns stage_hunk<CR>", mode = "x", silent = true, desc = "󰊢 Stage Selection" },
                { "gA", "<cmd>Gitsigns stage_buffer<CR>", desc = "󰊢 Add Buffer" },
                { "gh", "<cmd>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "󱡔 󰊢 Hunk textobj" },
                { "<leader>g?", function() require("gitsigns").blame_line() end, desc = " Blame Line" },
                { "<leader>g!", function() require("gitsigns").blame() end, desc = " Blame File" },

                -- UNDO
                { "<leader>ua", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "󰊢 Unstage Last Stage" },
                { "<leader>uA", "<cmd>Gitsigns reset_buffer_index<CR>", desc = "󰊢 Unstage Buffer" },
                { "<leader>ub", "<cmd>Gitsigns reset_buffer<CR>", desc = "󰊢 Reset Buffer" },
                { "<leader>uh", "<cmd>Gitsigns reset_hunk<CR>", mode = { "n", "x" }, desc = "󰊢 Reset Hunk" },

                -- OPTIONS
                { "<leader>og", function() require("gitsigns").toggle_signs() end, desc = "󰊢 Toggle Gitsigns" },
                -- stylua: ignore end
                {
                        "<leader>op",
                        function()
                                if vim.b.gitsignsPrevChanges then
                                        require("gitsigns").reset_base()
                                        vim.notify("Gitsigns: Reset Base")
                                        vim.b.gitsignsPrevChanges = false
                                        return
                                end

                                local file    = vim.api.nvim_buf_get_name(0)
                                local gitArgs = { "git", "log", "-1", "--format=%h", "--", file }
                                local out     = vim.system(gitArgs):wait()
                                assert(out.code == 0, "git log failed")
                                local lastCommitToFile = vim.trim(out.stdout) .. "^"
                                require("gitsigns").change_base(lastCommitToFile)
                                vim.b.gitsignsPrevChanges = true
                                vim.notify("Gitsigns: Changed base to " .. lastCommitToFile)
                        end,
                        desc = "󰊢 Previous/Present Changes",
                },
        },
        opts   = {
                signs_staged_enable = true,
                attach_to_untracked = true,
                max_file_length     = 3000,
                count_chars         = { "", "󰬻", "󰬼", "󰬽", "󰬾", "󰬿", "󰭀", "󰭁", "󰭂", ["+"] = "+" },
                signs               = {
                        add          = { text = "▐" },
                        change       = { text = "▐" },
                        delete       = { text = "🭻", show_count = true },
                        topdelete    = { text = "🭶", show_count = true },
                        changedelete = { text = "~", show_count = true },
                        untracked    = { text = "🬠" },
                },
                signs_staged        = {
                        add          = { text = "▐" },
                        change       = { text = "▐" },
                        delete       = { text = "🭻", show_count = true },
                        topdelete    = { text = "🭶", show_count = true },
                        changedelete = { text = "~", show_count = true },
                        untracked    = { text = "🬠" },
                },
                preview_config      = { border = "none" },
        },
        config = function(_, opts)
                require("gitsigns").setup(opts)
        end,
}
