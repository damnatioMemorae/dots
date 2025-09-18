return {
        cmd               = { "emmylua_ls" },
        filetypes         = { "lua" },
        root_markers      = {
                ".emmyrc.json",
                ".git",
                ".luacheckrc",
                ".luarc.jsonc",
                ".selene.yml",
                "selene.yml",
                ".stylua.toml",
                "stylua.toml",
        },
        require_workspace = false,
}
