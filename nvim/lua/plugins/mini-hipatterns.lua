return {
        "echasnovski/mini.hipatterns",
        version = false,
        event   = "VeryLazy",
        config  = function()
                local hipatterns       = require("mini.hipatterns")

                local words            = {
                        ["ivory"]       = "#dce0e8",
                        ["spark"]       = "#add8e6",
                        ["C.rosewater"] = "#f5e0dc",
                        ["C.flamingo"]  = "#f2cdcd",
                        ["C.pink"]      = "#f5c2e7",
                        ["C.mauve"]     = "#cba6f7",
                        ["C.red"]       = "#f38ba8",
                        ["C.maroon"]    = "#eba0ac",
                        ["C.peach"]     = "#fab387",
                        ["C.yellow"]    = "#f9e2af",
                        ["C.green"]     = "#a6e3a1",
                        ["C.teal"]      = "#94e2d5",
                        ["C.sky"]       = "#89dceb",
                        ["C.sapphire"]  = "#74c7ec",
                        ["C.blue"]      = "#89b4fa",
                        ["C.lavender"]  = "#b4befe",
                        ["C.text"]      = "#cdd6f4",
                        ["C.subtext1"]  = "#bac2de",
                        ["C.subtext0"]  = "#a6adc8",
                        ["C.overlay2"]  = "#9399b2",
                        ["C.overlay1"]  = "#7f849c",
                        ["C.overlay0"]  = "#6c7086",
                        ["C.surface2"]  = "#585b70",
                        ["C.surface1"]  = "#45475a",
                        ["C.surface0"]  = "#313244",
                        ["C.base"]      = "#1e1e2e",
                        ["C.mantle"]    = "#14141f",
                        ["C.crust"]     = "#0e0e16",
                }

                local word_color_group = function(_, match)
                        local hex = words[match]
                        if hex == nil then return nil end
                        return hipatterns.compute_hex_color_group(hex, "bg")
                end

                local hsl_to_hex       = function(h, s, l)
                        -- Actually convert h, s, l numbers into hex color in '#RRGGBB' format
                        return "#111111"
                end

                local hsl_color        = function(_, match)
                        local h, s, l   = match:match("hsl%((%d+) (%d+)%% (%d+)%%%)")
                        h, s, l         = tonumber(h), tonumber(s), tonumber(l)
                        local hex_color = hsl_to_hex(h, s, l)
                        return hipatterns.compute_hex_color_group(hex_color, "bg")
                end

                hipatterns.setup({
                        highlighters = {
                                fix        = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
                                fixme      = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                                hack       = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                                todo       = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                                note       = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

                                hex_color  = hipatterns.gen_highlighter.hex_color(),
                                word_color = { pattern = "%f[%w]()%S+()%f[%W]", group = word_color_group },
                                hsl_color  = {
                                        pattern = "hsl%(%d+,? %d+,? %d+%)",
                                        -- group = hsl_color()
                                        group = function(_, match)
                                                local utils     = require("core.utils")
                                                local h, s, l   = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
                                                h, s, l         = tonumber(h), tonumber(s), tonumber(l)
                                                local hex_color = utils.hslToHex(h, s, l)
                                                return hipatterns.compute_hex_color_group(hex_color, "bg")
                                        end,
                                },
                        },
                })
        end,
}
