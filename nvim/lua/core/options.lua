local arrows = require("core.icons").arrows
local misc   = require("core.icons").misc
local opt    = vim.opt
---@diagnostic disable-next-line: unused-local
local o      = vim.o

------------------------------------------------------------------------------------------------------------------------
-- GENERAL

opt.spelloptions:append("noplainbuffer")

opt.undofile    = true
opt.undolevels  = 10000
opt.swapfile    = false
opt.backup      = false
opt.writebackup = false

opt.spell       = false
-- opt.spellfile
opt.spelllang   = "en_us"

opt.splitright  = true
opt.splitbelow  = true

opt.cursorline  = true
-- opt.signcolumn  = "yes:2"
opt.signcolumn  = "yes:1"
-- opt.foldcolumn  = "1"

opt.wrap        = false
opt.breakindent = true

opt.report      = 9901

opt.iskeyword:append("-")
-- opt.nrformats = {}

opt.autowrite     = false
opt.autowriteall  = false

opt.jumpoptions   = { "stack" }
opt.startofline   = true

-- opt.timeoutlen     = 666

opt.scrolloff     = 14
opt.sidescrolloff = 4

-- opt.messagesopt   = "wait:100"
opt.shortmess     = "qFSIsoa"

------------------------------------------------------------------------------------------------------------------------
-- EDITOR

opt.textwidth     = 120

opt.expandtab     = true
-- opt.tabstop = 3
opt.shiftwidth    = 8

opt.shiftround    = true
opt.smartindent   = true
opt.autoindent    = true
opt.breakindent   = true
opt.copyindent    = true

------------------------------------------------------------------------------------------------------------------------
-- FILETYPES

vim.filetype.add{
        extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
        filename  = {
                [".ignore"] = "gitignore",
        },
        pattern   = {
                [".*/kitty/.+%.conf"] = "kitty",
                [".*/hypr/.+%.conf"]  = "hyprlang",
        },
}

------------------------------------------------------------------------------------------------------------------------
-- SEARCH & CMDLINE

opt.ignorecase   = true
opt.smartcase    = true
opt.hlsearch     = false
opt.inccommand   = "split"
opt.cmdheight    = 0

------------------------------------------------------------------------------------------------------------------------
-- INVISIBLE CHARS

opt.list         = true
opt.conceallevel = 3
opt.fillchars:append{
        fold      = " ",
        vert      = "▕",
        eob       = " ",
        foldclose = arrows.close,
        foldopen  = arrows.open,
        foldsep   = "│",
        diff      = "╱",
}

opt.listchars      = {
        nbsp       = " ",
        precedes   = misc.ellipsis,
        extends    = misc.ellipsis,
        multispace = " ",
        lead       = " ",
        trail      = " ",
        tab        = "  ",
}

opt.winborder      = "none"
opt.mousemoveevent = true
opt.completeopt    = "menu,menuone,noselect"
opt.confirm        = true
opt.grepformat     = "%f:%l:%c:%m"
opt.grepprg        = "rg --vimgrep"
opt.inccommand     = "nosplit"
opt.incsearch      = true
opt.linebreak      = false
opt.list           = true
opt.mouse          = "a"
opt.number         = true
opt.pumblend       = 10
opt.pumheight      = 20
opt.relativenumber = true
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.showmode       = false
opt.syntax         = "on"
opt.termguicolors  = true
opt.termsync       = true
opt.updatetime     = 300
opt.virtualedit    = "block"
opt.wildmode       = "longest:full,full"
opt.winminwidth    = 5
opt.wrapmargin     = 120

opt.smoothscroll   = true


vim.g.markdown_recommended_style = 0

vim.cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o")

vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
        group    = vim.api.nvim_create_augroup("Color", {}),
        pattern  = "*",
        callback = function() end,
})

for _, plugin in pairs({
        "netrwFileHandler",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
}) do
        vim.g["loaded_" .. plugin] = 1
end
