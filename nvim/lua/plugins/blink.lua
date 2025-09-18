return {
        "saghen/blink.cmp",
        event        = "VeryLazy",
        dependencies = {
                {
                        "L3MON4D3/LuaSnip",
                        dependencies = {
                                "rafamadriz/friendly-snippets",
                                config = function()
                                        require("luasnip.loaders.from_vscode").lazy_load()
                                end,
                        },
                },
                { "samiulsami/cmp-go-deep" },
                { "saghen/blink.compat" },
                { "bydlw98/blink-cmp-env" },
                { "MahanRahmati/blink-nerdfont.nvim" },
                { "niuiic/blink-cmp-rg.nvim" },
                { "jdrupal-dev/css-vars.nvim" },
                { "archie-judd/blink-cmp-words" },
                { "mgalliou/blink-cmp-tmux" },
        },
        opts         = {
                snippets   = { preset = "luasnip" },
                completion = {
                        keyword       = { range = "prefix" },
                        trigger       = {
                                prefetch_on_insert                   = true,
                                show_on_backspace                    = true,
                                show_on_backspace_in_keyword         = true,
                                show_on_backspace_after_accept       = true,
                                show_on_backspace_after_insert_enter = true,
                                show_on_insert                       = true,
                                show_on_accept_on_trigger_characters = true,
                                show_on_blocked_trigger_characters   = {},
                        },
                        list          = {
                                selection = { preselect = false, auto_insert = false },
                                cycle     = { from_bottom = true, from_top = true },
                        },
                        menu          = {
                                min_width          = 30,
                                max_height         = 20,
                                border             = nil,
                                winblend           = 0,
                                scrolloff          = 4,
                                scrollbar          = true,
                                direction_priority = { "s", "n" },
                                auto_show          = true,
                                draw               = {
                                        align_to   = "label",
                                        padding    = 1,
                                        gap        = 1,
                                        treesitter = { "lsp" },
                                        columns    = {
                                                { "kind_icon",   gap = 0 },
                                                { "label",       gap = 0 },
                                                { "source_name", gap = 0 },
                                                { "kind",        gap = 0 },
                                        },
                                        components = {
                                                kind_icon   = {
                                                        ellipsis = false,
                                                        text     = function(ctx)
                                                                if ctx.source_id == "cmdline" then return end
                                                                return ctx.kind_icon
                                                        end,
                                                },
                                                source_name = {
                                                        -- text = function(ctx) return "[" .. ctx.source_name .. "]" end,
                                                        text = function(ctx)
                                                                if ctx.source_id == "cmdline" then return end
                                                                return ctx.source_name:sub(1, 4)
                                                                -- return "[" .. ctx.source_name:sub(1, 4) .. "]"
                                                        end,
                                                },
                                        },
                                },
                        },
                        documentation = { auto_show = true, auto_show_delay_ms = 50 },
                        signature     = {
                                enabled = true,
                                trigger = { enabled = true },
                                window  = { show_documentation = true },
                        },
                },
                fuzzy      = {
                        implementation    = "prefer_rust",
                        -- implementation = "lua",
                        max_typos         = 0,
                        use_frecency      = true,
                        use_proximity     = true,
                        sorts             = {
                                function(a, b)
                                        if a.label:sub(1, 1) == "_" ~= a.label:sub(1, 1) == "_" then
                                                return not a.label:sub(1, 1) == "_"
                                        end
                                end,
                                "exact",
                                "score",
                                "sort_text",
                        },
                        prebuilt_binaries = {
                                download      = true,
                                force_version = "1.*",
                        },
                },
                cmdline    = {
                        enabled    = true,
                        keymap     = {
                                preset        = "none",
                                ["<C-h>"]     = { "snippet_backward", "fallback" },
                                ["<C-l>"]     = { "snippet_forward", "fallback" },
                                ["<C-j>"]     = { "select_next", "fallback" },
                                ["<C-k>"]     = { "select_prev", "fallback" },
                                ["<C-c>"]     = { function(cmp) if cmp.is_menu_visible() then cmp.hide() else cmp.show() end end },
                                ["<C-Space>"] = {
                                        function(cmp)
                                                if cmp.is_menu_visible() then
                                                        cmp.accept()
                                                        cmp.hide()
                                                else
                                                        cmp.show()
                                                end
                                        end,
                                },
                        },
                        sources    = function()
                                local type = vim.fn.getcmdtype()
                                -- Search forward and backward
                                if type == "/" or type == "?" then return { "buffer" } end
                                -- Commands
                                if type == ":" or type == "@" then return { "cmdline" } end
                                return {}
                        end,
                        completion = {
                                trigger = {
                                        show_on_blocked_trigger_characters   = {},
                                        show_on_x_blocked_trigger_characters = {},
                                },
                                list    = { selection = { preselect = false, auto_insert = false } },
                                menu    = { auto_show = false },
                        },
                },
                sources    = {
                        -- default      = { "snippets", "lsp", "path", "buffer", },
                        default      = function(ctx)
                                local success, node = pcall(vim.treesitter.get_node)
                                if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
                                        return { "buffer", "ripgrep", "blink-cmp-words" }
                                else
                                        return { "snippets", "lsp", "path", "buffer" }
                                end
                        end,
                        per_filetype = {
                                ["rip-substitute"] = { "ripgrep", "buffer" },
                                gitcommit          = {},
                                lua                = { inherit_defaults = true, "ripgrep" },
                                c                  = { inherit_defaults = true, "ripgrep", "env" },
                                cpp                = { inherit_defaults = true, "ripgrep", "env" },
                                css                = { inherit_defaults = true, "ripgrep", "nerdfont", "css_vars" },
                                json               = { inherit_defaults = true, "ripgrep", "nerdfont" },
                                jsons              = { inherit_defaults = true, "ripgrep", "nerdfont" },
                                go                 = { inherit_defaults = true, "ripgrep", "go_deep" },
                        },
                        providers    = {
                                snippets = {
                                        name               = "Snip",
                                        score_offset       = 140,
                                        min_keyword_length = 2,
                                },
                                go_deep  = {
                                        name         = "go_deep",
                                        module       = "blink.compat.source",
                                        score_offset = 180,
                                        opts         = {},
                                },
                                lsp      = {
                                        enabled      = function()
                                                if vim.bo.ft ~= "lua" then return true end
                                                local col                 = vim.api.nvim_win_get_cursor(0)[2]
                                                local charsBefore         = vim.api.nvim_get_current_line():sub(col - 2,
                                                                                                                col)
                                                local luadocButNotComment = not charsBefore:find("^%-%-?$")
                                                           and not charsBefore:find("%s%-%-?")
                                                return luadocButNotComment
                                        end,
                                        name         = "LSP",
                                        module       = "blink.cmp.sources.lsp",
                                        score_offset = 160,
                                        fallbacks    = {},
                                        override     = {
                                                get_trigger_characters = function(self)
                                                        local trigger_characters = self:get_trigger_characters()
                                                        vim.list_extend(trigger_characters, { "\n", "\t", " " })
                                                        return trigger_characters
                                                end,
                                        },
                                },
                                path     = {
                                        name         = "Path",
                                        module       = "blink.cmp.sources.path",
                                        score_offset = 260,
                                        opts         = {
                                                trailing_slash               = true,
                                                label_trailing_slash         = true,
                                                get_cwd                      = function(_)
                                                        -- return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                                                        return vim.fn.getcwd()
                                                end,
                                                show_hidden_files_by_default = true,
                                        },
                                },
                                buffer   = {
                                        name         = "Buf",
                                        score_offset = 60,
                                        max_items    = 8,
                                        opts         = {
                                                get_bufnrs = vim.api.nvim_list_bufs,
                                                -- get_bufnrs = function()
                                                --         return vim.tbl_filter(function(bufnr)
                                                --                 return vim.bo[bufnr].buftype == ''
                                                --         end, vim.api.nvim_list_bufs())
                                                -- end
                                        },
                                },
                                css_vars = {
                                        name   = "CSS",
                                        module = "css-vars.blink",
                                },
                                omni     = {
                                        name         = "Omni",
                                        module       = "blink.cmp.sources.complete_func",
                                        score_offset = 60,
                                        opts         = {
                                                disable_omnifunc = { "v:lua.vim.lsp.omnifunc" },
                                        },
                                },
                                env      = {
                                        name         = "Env",
                                        module       = "blink-cmp-env",
                                        max_items    = 4,
                                        score_offset = 4,
                                        opts         = {
                                                show_braces               = true,
                                                show_documentation_window = true,
                                        },
                                },
                                nerdfont = {
                                        module       = "blink-nerdfont",
                                        name         = "Nerd",
                                        score_offset = 10,
                                        opts         = { insert = true },
                                },
                                ripgrep  = {
                                        module       = "blink-cmp-rg",
                                        name         = "RG",
                                        score_offset = 10,
                                        max_items    = 4,
                                        opts         = {
                                                prefix_min_len = 3,
                                                get_command    = function(context, prefix)
                                                        return {
                                                                "rg",
                                                                "--no-config",
                                                                "--json",
                                                                "--word-regexp",
                                                                "--smart-case",
                                                                "--",
                                                                prefix .. "[\\w_-]+",
                                                                vim.fs.root(0, ".git") or vim.fn.getcwd(),
                                                        }
                                                end,
                                                get_prefix     = function(context)
                                                        return context.line:sub(1, context.cursor[2]):match("[%w_-]+$") or
                                                                   ""
                                                end,
                                        },
                                },
                        },
                },
                keymap     = {
                        preset        = "enter",
                        ["<A-j>"]     = { "scroll_documentation_down", "fallback" },
                        ["<A-k>"]     = { "scroll_documentation_up", "fallback" },
                        ["<C-j>"]     = { "select_next", "fallback" },
                        ["<C-k>"]     = { "select_prev", "fallback" },
                        ["<C-c>"]     = { function(cmp) if cmp.is_menu_visible() then cmp.hide() else cmp.show() end end },
                        ["<Tab>"]     = { "select_next", "snippet_forward", "fallback" },
                        ["<S-Tab>"]   = { "select_prev", "snippet_backward", "fallback" },
                        ["<C-Space>"] = {
                                function(cmp)
                                        if cmp.is_menu_visible() then
                                                cmp.accept()
                                                cmp.hide()
                                        else
                                                cmp.show()
                                        end
                                end,
                        },
                },
                appearance = {
                        nerd_font_variant = "normal",
                        kind_icons        = require("core.icons").symbol_kinds,
                },
                signature  = { enabled = false, window = { scrollbar = false } },
        },
        opts_extend  = { "sources.default" },
        config       = function(_, opts)
                require("blink-cmp").setup(opts)
        end,
}
