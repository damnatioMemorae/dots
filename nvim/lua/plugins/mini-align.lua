return {
        "echasnovski/mini.align",
        version = false,
        event   = "VeryLazy",
        opts    = {
                mappings = {
                        start              = "ma",
                        start_with_preview = "ma",
                },

                options  = {
                        split_pattern   = "",
                        justify_side    = "left",
                        merge_delimiter = "",
                },

                steps    = {
                        pre_split   = {},
                        split       = nil,
                        pre_justify = {},
                        justify     = nil,
                        pre_merge   = {},
                        merge       = nil,
                },

                silent   = false,
        }
}
