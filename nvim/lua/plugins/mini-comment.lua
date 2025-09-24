return {
        "nvim-mini/mini.comment",
        enabled = false,
        version = false,
        event   = "VeryLazy",
        opts    =
        {
                options  = {
                        custom_commentstring = nil,
                        ignore_blank_line    = false,
                        start_of_line        = false,
                        pad_comment_parts    = true,
                },
                mappings = {
                        comment        = "q",
                        comment_line   = "qq",
                        comment_visual = "q",
                        textobject     = "q",
                },
                hooks    = {
                        pre  = function() end,
                        post = function() end,
                },
        },
}
