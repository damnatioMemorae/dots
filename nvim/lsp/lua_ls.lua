return {
        cmd          = { "lua-language-server", "--force-accept-workspace" },
        filetypes    = { "lua" },
        root_markers = {
                ".luarc.json",
                ".luarc.jsonc",
                ".luacheckrc",
                ".stylua.toml",
                "stylua.toml",
                "selene.toml",
                "selene.yml",
                ".git",
        },
        ---[[,
        on_init      = function(client)
                if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if
                                   path ~= vim.fn.stdpath("config")
                                   and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                        then
                                return
                        end
                end

                client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime   = {
                                version = "LuaJIT",
                                path    = {
                                        "lua/?.lua",
                                        "lua/?/init.lua",
                                },
                        },
                        workspace = {
                                checkThirdParty = false,
                                library         = {
                                        vim.env.VIMRUNTIME,
                                },
                        },
                })
        end,
        --]]
        settings     = {
                completion    = {
                        callSnippet = "Both",
                        postfix     = "@",
                        showWord    = "Enable",
                },
                hint          = {
                        enable         = true,
                        awaitPropagate = true,
                        setType        = true,
                },
                hover         = { enable = false },
                signatureHelp = { enable = false },
                semantic      = {
                        enable     = true,
                        annotation = true,
                        keyword    = true,
                        variable   = true,
                },
                telemetry     = { enable = false },
                Lua           = {
                        diagnostics = {
                                disable = { "trailing-space", "unused-function", "lowercase-global" },
                                -- workspaceEvent = "OnSave",
                        },
                        hint        = { enable = true, setType = true, arrayIndex = "Auto", semicolon = "Disable" },
                        format      = { enable = true },
                        semantic    = {
                                enable   = false,
                                -- keyword   = true,
                                variable = false,
                        },
                        completion  = {
                                callSnippet    = "Replace", -- functions -> no replace snippet
                                keywordSnippet = "Replace", -- keywords -> replace
                                showWord       = "Enable",  -- already done by completion plugin
                                workspaceWord  = true,      -- already done by completion plugin
                                postfix        = "@",       -- useful for `table.insert` and the like
                        },
                },
        },
}
