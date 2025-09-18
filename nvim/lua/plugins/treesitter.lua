return {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPre",
        build = ":TSUpdate",
        main  = "nvim-treesitter.configs",
        opts  = {
                ensure_installed      = "all",
                ignore_install        = { "comment" },
                highlight             = {
                        enable  = true,
                        disable = function(_, bufnr)
                                local maxFilesizeKb = 100
                                local ok, stats     = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
                                if ok and stats and stats.size > maxFilesizeKb * 1024 then return true end
                        end,
                },
                indent                = {
                        enable  = true,
                        disable = { "markdown" },
                },
                textobjects           = {
                        select = {
                                lookahead                      = true,
                                include_surrounding_whitespace = false,
                        },
                },
                incremental_selection = {
                        enable  = true,
                        keymaps = {
                                init_selection    = "<leader>v",
                                node_incremental  = "<CR>",
                                node_decremental  = "<Backspace>",
                                scope_incremental = false,
                        }
                }
        },
        { -- NODE ACTIONS
                "ckolkey/ts-node-action",
                dependencies = { "nvim-treesitter" },
                -- config = function()
                --     require("ts-node-action").setup({})
                -- end
        },
        { -- HYPRLANG
                "theRealCarneiro/hyprland-vim-syntax",
                dependencies = { "nvim-treesitter/nvim-treesitter" },
                ft           = "hypr",
        },
        { -- CONTEXT
                "nvim-treesitter/nvim-treesitter-context",
                dependencies = { "nvim-treesitter/nvim-treesitter" },
                event        = "VeryLazy",
                config       = function()
                        require "treesitter-context".setup {
                                enable              = true,
                                multiwindow         = false,
                                max_lines           = 2,
                                min_window_height   = 1,
                                line_numbers        = true,
                                multiline_threshold = 20,
                                trim_scope          = "outer",
                                mode                = "cursor",
                                separator           = nil,
                                zindex              = 20,
                                on_attach           = nil,
                        }

                        vim.api.nvim_set_hl(0, "TreesitterContextLineNumberBottom", { underline = false })
                        vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = false })

                        vim.keymap.set("n", ",c", function()
                                require("treesitter-context").go_to_context(vim.v.count1)
                        end, { silent = true })
                end
        },
}
