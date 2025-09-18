local textObjMaps = require("core.utils").extraTextobjMaps
--------------------------------------------------------------------------------

return {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        keys  = {
                { "ys", desc = "󰅪 Add Surround Op." },
                { "yS", "ys$", desc = "󰅪 Surround to EoL", remap = true },
                { "ds", desc = "󰅪 Delete Surround Op." },
                { "cs", desc = "󰅪 Change Surround Op." },
        },
        opts  = {
                move_cursor = false,
                aliases     = { c = "}", r = "]", m = "W", q = '"', z = "'", e = "`" },
                keymaps     = {
                        visual          = false,
                        normal_line     = false,
                        normal_cur_line = false,
                        visual_line     = false,
                        insert_line     = false,
                        insert          = false,
                },
                surrounds   = {
                        invalid_key_behavior    = { add = false, find = false, delete = false, change = false },
                        [textObjMaps.call]      = {
                                find   = "[%w.:_]+%b()", -- includes `:` for LUA-methods/CSS-pseudoclasses
                                delete = "([%w.:_]+%()().*(%))()",
                        },
                        [textObjMaps.func]      = {
                                -- only one-line lua functions
                                find   = "function ?[%w_]* ?%b().- end",
                                delete = "(function ?[%w_]* ?%b() ?)().-( end)()",
                        },
                        [textObjMaps.condition] = {
                                -- only one-line lua conditionals
                                find   = "if .- then .- end",
                                delete = "(if .- then )().-( end)()",
                        },
                },
        },
}
