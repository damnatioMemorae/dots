return {
        "nvim-mini/mini.splitjoin",
        version = false,
        event   = "VeryLazy",
        opts    = {
                mappings = { toggle = "<leader>s", split = "", join = "" },
                detect   = { brackets = nil, separator = ",", exclude_regions = nil },
                split    = { hooks_pre = {}, hooks_post = {} },
                join     = { hooks_pre = {}, hooks_post = {} },
        },
}
