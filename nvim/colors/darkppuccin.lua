vim.cmd.highlight "clear"
if vim.fn.exists "syntax_on" then
        vim.cmd.syntax "reset"
end
vim.o.termguicolors = true
vim.g.colors_name   = "darkppuccin"


local colors = {
        rosewater = "#f5e0dc",
        flamingo  = "#f2cdcd",
        pink      = "#f5c2e7",
        mauve     = "#cba6f7",
        red       = "#f38ba8",
        maroon    = "#eba0ac",
        peach     = "#fab387",
        yellow    = "#f9e2af",
        green     = "#a6e3a1",
        teal      = "#94e2d5",
        sky       = "#89dceb",
        sapphire  = "#74c7ec",
        blue      = "#89b4fa",
        lavender  = "#b4befe",
        text      = "#cdd6f4",
        subtext1  = "#bac2de",
        subtext0  = "#a6adc8",
        overlay2  = "#9399b2",
        overlay1  = "#7f849c",
        overlay0  = "#6c7086",
        surface2  = "#585b70",
        surface1  = "#45475a",
        surface0  = "#313244",
        base      = "#1e1e2e",
        mantle    = "#181825",
        crust     = "#11111b",
        ivory     = "#dce0e8"
}


------------------------------------------------------------------------------------------------------------------------
-- TERMINAL COLORS

-- vim.g.terminal_color_0           = colors.
-- vim.g.terminal_color_1           = colors.
-- vim.g.terminal_color_2           = colors.
-- vim.g.terminal_color_3           = colors.
-- vim.g.terminal_color_4           = colors.
-- vim.g.terminal_color_5           = colors.
-- vim.g.terminal_color_6           = colors.
-- vim.g.terminal_color_7           = colors.
-- vim.g.terminal_color_8           = colors.
-- vim.g.terminal_color_9           = colors.
-- vim.g.terminal_color_10          = colors.
-- vim.g.terminal_color_11          = colors.
-- vim.g.terminal_color_12          = colors.
-- vim.g.terminal_color_13          = colors.
-- vim.g.terminal_color_14          = colors.
-- vim.g.terminal_color_15          = colors.
vim.g.terminal_color_background = colors.crust
vim.g.terminal_color_foreground = colors.text


local statutsline_groups = {}

for mode, color in pairs {
        Normal  = "mauve",
        Pending = "pink",
        Visual  = "yellow",
        Insert  = "green",
        Command = "sky",
        Other   = "peach",
} do
        statusline_groups["StatuslineMode" .. mode]          = { fg = colors.crust, bg = colors[color] }
        statusline_groups["StatuslineModeSeparator" .. mode] = { fg = colors[color], bg = colors.crust }
end

statusline_groups = vim.tbl_extend("error", statusline_groups, {
        StatuslineItalic  = { fg = colors.surface0, bg = colors.crust, italic = true },
        StatuslineSpinner = { fg = colors.green, bg = colors.crust, bold = true },
        StatuslineTitle   = { fg = colors.text, bg = colors.crust, bold = true },
})

---@type table<string, vim.api.keyset.highlight>
local groups = vim.tbl_extend("error", statutsline_groups, {

        ----------------------------------------------------------------------------------------------------------------
        -- BUILTINS

        Boolean                     = { fg = colors.peach },
        Character                   = { fg = colors.green },
        -- ColorColumn                   = { bg = colors.},
        Comment                     = { link = "NonText" },
        Conceal                     = { link = "NonText" },
        Conditional                 = { fg = colors.sky },
        Constant                    = { fg = colors.peach },
        CurSearch                   = { fg = colors.crust, bg = colors.red },
        Cursor                      = { fg = colors.crust, bg = colors.red },
        -- CursorColumn                  = { bg = colors.},
        CursorLine                  = { bg = colors.none },
        CursorLineNr                = { fg = colors.rosewater },
        Define                      = { fg = colors.pink },
        Directory                   = { fg = colors.ivory },
        -- EndOfBuffer                   = { fg = colors.},
        Error                       = { fg = colors.red },
        ErrorMsg                    = { fg = colors.red },
        -- FoldColumn                    = {},
        Folded                      = { link = "Visual" },
        Function                    = { fg = colors.ivory },
        Identifier                  = { fg = colors.flamingo },
        IncSearch                   = { link = "CurSearch" },
        Include                     = { fg = colors.mauve },
        Keyword                     = { fg = colors.yellow },
        Label                       = { fg = colors.sky },
        LineNr                      = { link = "NonText" },
        Macro                       = { fg = colors.mauve },
        -- MatchParen                    = { sp = colors., underline = true },
        NonText                     = { fg = colors.surface0 },
        Normal                      = { bg = colors.crust },
        NormalFloat                 = { bg = colors.mantle },
        Number                      = { fg = colors.peach },
        Pmenu                       = { bg = colors.crust },
        -- PmenuSbar                     = { bg = colors.},
        PmenuSel                    = { link = "Visual" },
        -- PmenuThumb                    = { bg = colors.},
        PreCondit                   = { link = "PreProc" },
        PreProc                     = { fg = colors.pink },
        Question                    = { fg = colors.teal },
        Repeat                      = { link = "Conditional" },
        -- Search                        = { fg = colors., bg = colors.},
        SignColumn                  = { link = "NonText" },
        Special                     = { fg = colors.pink, italic = true },
        SpecialComment              = { link = "Special" },
        SpecialKey                  = { link = "NonText" },
        SpellBad                    = { sp = colors.red, underline = true },
        SpellCap                    = { sp = colors.yellow, underline = true },
        SpellLocal                  = { sp = colors.blue, underline = true },
        SpellRare                   = { sp = colors.green, underline = true },
        Statement                   = { fg = colors.red },
        -- StatusLine                    = { fg = colors., bg = colors.},
        StorageClass                = { fg = colors.teal },
        Structure                   = { fg = colors.teal },
        -- Substitute                    = { fg = colors., bg = colors., bold = true },
        Title                       = { fg = colors.red },
        -- Todo                          = { fg = colors., bold = true, italic = true },
        Type                        = { link = "Keyword" },
        TypeDef                     = { link = "Type" },
        -- Underlined                    = { fg = colors., underline = true },
        VertSplit                   = { link = "NonText" },
        Visual                      = { fg = colors.none, bg = colors.none, bold = true },
        -- VisualNOS                     = { fg = colors.},
        WarningMsg                  = { fg = colors.yellow },
        WildMenu                    = { bg = colors.mantle },

        ----------------------------------------------------------------------------------------------------------------
        -- TREESITTER

        ["@annotation"]             = { fg = colors.yellow },
        ["@attribute"]              = { fg = colors.teal },
        ["@boolean"]                = { fg = colors.peach },
        ["@character"]              = { fg = colors.green },
        ["@constant"]               = { fg = colors.peach },
        ["@constant.builtin"]       = { fg = colors.peach },
        ["@constant.macro"]         = { fg = colors.mauve },
        ["@constructor"]            = { fg = colors.sky },
        ["@error"]                  = { fg = colors.red },
        ["@function"]               = { fg = colors.ivory },
        ["@function.builtin"]       = { fg = colors.peach },
        ["@function.macro"]         = { fg = colors.teal },
        ["@function.method"]        = { fg = colors.ivory },
        ["@keyword"]                = { fg = colors.yellow },
        ["@keyword.conditional"]    = { fg = colors.sky },
        ["@keyword.exception"]      = { fg = colors.mauve },
        ["@keyword.function"]       = { fg = colors.ivory },
        ["@keyword.function.ruby"]  = { fg = colors.ivory },
        ["@keyword.include"]        = { fg = colors.mauve },
        ["@keyword.operator"]       = { link = "@keyword.conditional" },
        ["@keyword.repeat"]         = { link = "@keyword.conditional" },
        ["@label"]                  = { fg = colors.sapphire },
        ["@markup"]                 = { fg = colors.text },
        -- ["@markup.emphasis"]          = { fg = colors., italic = true },
        -- ["@markup.heading"]           = { fg = colors., bold = true },
        -- ["@markup.link"]              = { fg = colors., bold = true },
        ["@markup.link.url"]        = { fg = colors.teal, italic = true },
        ["@markup.list"]            = { fg = colors.pink },
        ["@markup.raw"]             = { fg = colors.teal },
        ["@markup.strong"]          = { fg = colors.maroon, bold = true },
        ["@markup.underline"]       = { fg = colors.peach },
        ["@module"]                 = { fg = colors.yellow },
        ["@number"]                 = { link = "Number" },
        ["@number.float"]           = { link = "Number" },
        ["@operator"]               = { link = "@keyword.operator" },
        -- ["@parameter.reference"]      = { fg = colors.},
        ["@property"]               = { fg = colors.blue },
        ["@punctuation.bracket"]    = { link = "NonText" },
        ["@punctuation.delimiter"]  = { link = "NonText" },
        ["@string"]                 = { fg = colors.green },
        ["@string.escape"]          = { fg = colors.pink },
        ["@string.regexp"]          = { fg = colors.peach },
        ["@string.special.symbol"]  = { fg = colors.flamingo },
        ["@structure"]              = { fg = colors.teal },
        ["@tag"]                    = { fg = colors.ared },
        ["@tag.attribute"]          = { fg = colors.teal },
        ["@tag.delimiter"]          = { fg = colors.sky },
        ["@type"]                   = { fg = colors.yellow },
        ["@type.builtin"]           = { fg = colors.yellow, italic = true },
        ["@type.qualifier"]         = { fg = colors.mauve },
        ["@variable"]               = { fg = colors.red },
        ["@variable.builtin"]       = { fg = colors.red },
        ["@variable.member"]        = { fg = colors.ivory },
        ["@variable.parameter"]     = { fg = colors.maroon },

        ----------------------------------------------------------------------------------------------------------------
        -- SEMANTIC TOKENS

        ["@class"]                  = { fg = colors.teal },
        ["@decorator"]              = { fg = colors.peach },
        ["@enum"]                   = { fg = colors.peach },
        ["@enumMember"]             = { fg = colors.peach },
        ["@event"]                  = { fg = colors.yellow },
        ["@interface"]              = { fg = colors.teal },
        ["@lsp.type.class"]         = { fg = colors.teal },
        ["@lsp.type.decorator"]     = { fg = colors.peach },
        ["@lsp.type.enum"]          = { fg = colors.peach },
        ["@lsp.type.enumMember"]    = { fg = colors.peach },
        ["@lsp.type.function"]      = { fg = colors.ivory },
        ["@lsp.type.interface"]     = { fg = colors.teal },
        ["@lsp.type.macro"]         = { fg = colors.mauve },
        ["@lsp.type.method"]        = { fg = colors.ivory },
        ["@lsp.type.namespace"]     = { fg = colors.yellow },
        ["@lsp.type.parameter"]     = { fg = colors.maroon },
        ["@lsp.type.property"]      = { fg = colors.blue },
        ["@lsp.type.struct"]        = { fg = colors.teal },
        ["@lsp.type.type"]          = { link = "NonText" },
        ["@lsp.type.variable"]      = { fg = colors.red },
        ["@modifier"]               = { fg = colors.mauve },
        ["@regexp"]                 = { fg = colors.peach },
        ["@struct"]                 = { fg = colors.teal },
        ["@typeParameter"]          = { fg = colors.yellow },

        ----------------------------------------------------------------------------------------------------------------
        -- PACKAGE MANAGER

        -- LazyDimmed                    = { fg = colors.},

        ----------------------------------------------------------------------------------------------------------------
        -- LSP.

        DiagnosticDeprecated        = { strikethrough = true, fg = colors.surface0 },
        DiagnosticError             = { fg = colors.red },
        DiagnosticFloatingError     = { fg = colors.red },
        DiagnosticFloatingHint      = { fg = colors.teal },
        DiagnosticFloatingInfo      = { fg = colors.sky },
        DiagnosticFloatingWarn      = { fg = colors.yellow },
        DiagnosticHint              = { fg = colors.teal },
        DiagnosticInfo              = { fg = colors.sky },
        DiagnosticUnderlineError    = { undercurl = true, sp = colors.red },
        DiagnosticUnderlineHint     = { undercurl = true, sp = colors.teal },
        DiagnosticUnderlineInfo     = { undercurl = true, sp = colors.sky },
        DiagnosticUnderlineWarn     = { undercurl = true, sp = colors.yellow },
        DiagnosticUnnecessary       = { link = "NonText" },
        DiagnosticVirtualTextError  = { fg = colors.red },
        DiagnosticVirtualTextHint   = { fg = colors.teal },
        DiagnosticVirtualTextInfo   = { fg = colors.sky },
        DiagnosticVirtualTextWarn   = { fg = colors.yellow },
        DiagnosticWarn              = { fg = colors.yellow },
        -- LspCodeLens                   = { fg = colors.},
        LspFloatWinBorder           = { fg = colors.mantle },
        LspInlayHint                = { fg = colors.surface0, italic = true },
        -- LspReferenceRead              = { bg = colors.},
        -- LspReferenceText              = {},
        -- LspReferenceWrite             = { bg = colors.},
        LspSignatureActiveParameter = { link = "Visual" },

        ----------------------------------------------------------------------------------------------------------------
        -- COMPLETIONS

        BlinkCmpKindClass           = { link = "@lsp.type.class" },
        BlinkCmpKindColor           = { link = "Define" },
        BlinkCmpKindConstant        = { link = "@constant" },
        BlinkCmpKindConstructor     = { link = "@constructor" },
        BlinkCmpKindEnum            = { link = "@variable.member" },
        BlinkCmpKindEnumMember      = { link = "@variable.member" },
        BlinkCmpKindEvent           = { link = "@constant" },
        BlinkCmpKindField           = { link = "@variable.member" },
        BlinkCmpKindFile            = { link = "Directory" },
        BlinkCmpKindFolder          = { link = "@function" },
        BlinkCmpKindFunction        = { link = "@function" },
        BlinkCmpKindInterface       = { link = "@lsp.type.interface" },
        BlinkCmpKindKeyword         = { link = "@keyword" },
        BlinkCmpKindMethod          = { link = "@function.method" },
        BlinkCmpKindModule          = { link = "@module" },
        BlinkCmpKindOperator        = { link = "@operator" },
        BlinkCmpKindProperty        = { link = "@property" },
        BlinkCmpKindReference       = { link = "@parameter.reference" },
        BlinkCmpKindSnippet         = { link = "@keyword" },
        BlinkCmpKindStruct          = { link = "@lsp.type.struct" },
        BlinkCmpKindText            = { link = "Nontext" },
        BlinkCmpKindTypeParameter   = { link = "@variable.parameter" },
        BlinkCmpKindUnit            = { link = "@variable.member" },
        BlinkCmpKindValue           = { link = "@variable.member" },
        BlinkCmpKindVariable        = { link = "@variable" },
        BlinkCmpLabelDeprecated     = { link = "DiagnosticDeprecated" },
        BlinkCmpLabelDescription    = { link = "Nontext" },
        BlinkCmpLabelDetail         = { link = "NonText" },
        BlinkCmpLabelMatch          = { link = "Visual" },
        BlinkCmpMenu                = { link = "Normal" },
        BlinkCmpMenuBorder          = { link = "Normal" },

        ----------------------------------------------------------------------------------------------------------------
        -- DAP UI

        -- DapStoppedLine                = { default = true, link = "Visual" },
        -- DapUIBreakpointsCurrentLine   = { fg = colors., bold = true },
        -- DapUIBreakpointsInfo          = { fg = colors.},
        -- DapUIBreakpointsPath          = { fg = colors.},
        -- DapUIDecoration               = { fg = colors.},
        -- DapUIFloatBorder              = { fg = colors.},
        -- DapUILineNumber               = { fg = colors.},
        -- DapUIModifiedValue            = { fg = colors., bold = true },
        -- DapUIPlayPause                = { fg = colors.},
        -- DapUIRestart                  = { fg = colors.},
        -- DapUIScope                    = { fg = colors.},
        -- DapUISource                   = { fg = colors.},
        -- DapUIStepBack                 = { fg = colors.},
        -- DapUIStepInto                 = { fg = colors.},
        -- DapUIStepOut                  = { fg = colors.},
        -- DapUIStepOver                 = { fg = colors.},
        -- DapUIStop                     = { fg = colors.},
        -- DapUIStoppedThread            = { fg = colors.},
        -- DapUIThread                   = { fg = colors.},
        -- DapUIType                     = { fg = colors.},
        -- DapUIWatchesEmpty             = { fg = colors.},
        -- DapUIWatchesError             = { fg = colors.},
        -- DapUIWatchesValue             = { fg = colors.},
        -- DapUIWinSelect                = { fg = colors., bold = true },
        -- NvimDapVirtualText            = { fg = colors., underline = true },

        ----------------------------------------------------------------------------------------------------------------
        -- DIFFS

        -- DiffAdd                       = { fg = colors., bg = colors.},
        -- DiffChange                    = { fg = colors., bg = colors.},
        -- DiffDelete                    = { fg = colors., bg = colors.},
        -- DiffText                      = { fg = colors., bg = colors., bold = true },
        -- DiffviewFolderSign            = { fg = colors.},
        -- DiffviewNonText               = { fg = colors.},
        -- diffAdded                     = { fg = colors., bold = true },
        -- diffChanged                   = { fg = colors., bold = true },
        -- diffRemoved                   = { fg = colors., bold = true },

        ----------------------------------------------------------------------------------------------------------------
        -- COMMAND LINE

        -- MoreMsg                       = { fg = colors., bold = true },
        -- MsgArea                       = { fg = colors.},
        -- MsgSeparator                  = { fg = colors.},

        ----------------------------------------------------------------------------------------------------------------
        -- WINBAR STYLING

        WinBar                      = { link = "Normal" },
        WinBarNC                    = { link = "Normal" },
        -- WinBarDir                     = { fg = colors., bg = colors., italic = true },
        -- WinBarSeparator               = { fg = colors., bg = colors.},

        ----------------------------------------------------------------------------------------------------------------
        -- QUICKFIX WINDOW

        -- QuickFixLine                  = { italic = true, bg = colors.},

        ----------------------------------------------------------------------------------------------------------------
        -- GITSIGNS

        GitSignsAdd                 = { fg = colors.green },
        GitSignsChange              = { fg = colors.yellow },
        GitSignsDelete              = { fg = colors.red },
        -- GitSignsStagedAdd             = { fg = colors.},
        -- GitSignsStagedChange          = { fg = colors.},
        -- GitSignsStagedDelete          = { fg = colors.},

        ----------------------------------------------------------------------------------------------------------------
        -- FLASH

        FlashMatch                  = { colors.ivory },
        FlashLabel                  = { colors.red },

        ----------------------------------------------------------------------------------------------------------------
        -- URL

        HighlightUrl                = { underline = true, fg = colors.teal, sp = colors.teal },
})

for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
end
