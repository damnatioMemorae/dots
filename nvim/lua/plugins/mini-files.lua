return {
        "echasnovski/mini.files",
        version = false,
        event   = "VeryLazy",
        keys    = { { ",m", function() require("mini.files").open() end, desc = "mini-files" } },
        opts    = { windows = { preview = true } }
}
