---@diagnostic disable: missing-parameter
---@diagnostic disable-next-line: unknown-diag-code
---@diagnostic disable: unused
---@diagnostic disable: unused-local

local map                 = require("core.utils").uniqueKeymap
local comments            = require("functions.comment")
local eval                = require("functions.inspect-and-eval")
local nano                = require("functions.nano-plugins")
local n, i, c, v, o, x, t = "n", "i", "c", "v", "o", "x", "t"


local ni    = { n, i }
local nx    = { n, x }
local nc    = { n, c }
local nv    = { n, v }
local no    = { n, o }
local nix   = { n, i, x }
local nic   = { n, i, c }
local niv   = { n, i, v }
local nio   = { n, i, o }
local nxcvo = { n, x, c, v, o }

------------------------------------------------------------------------------------------------------------------------
-- META

map(n, "ZZ", require("core.utils").safeQuit, { desc = " Safe Quit", silent = true })

local pluginDir = vim.fn.stdpath("data") --[[@as string]]
map(n, "<leader>pd", function() vim.ui.open(pluginDir) end, { desc = "󰝰 Plugin dir", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- NAVIGATION

map(n, "_", "0")

map(nx, "{", "{zz", { silent = true })
map(nx, "}", "}zz", { silent = true })

-- j/k should on wrapped lines
map(nx, "j", "gj")
map(nx, "k", "gk")

-- hjkl in INSERT mode
map(i, "<C-h>", "<Left>", { desc = "Left with h in INSERT mode", silent = true })
map(i, "<C-j>", "<Down>", { desc = "Down with j in INSERT mode", silent = true })
map(i, "<C-k>", "<Up>", { desc = "Up with k in INSERT mode", silent = true })
map(i, "<C-l>", "<Right>", { desc = "Right with l in INSERT mode", silent = true })
map(i, "<A-l>", "<C-o>A", { desc = "Right with l in INSERT mode", silent = true })

-- Better scroll
map(n, "<C-d>", "<C-d>zz", { desc = "Scroll down half page", silent = true })
map(n, "<C-u>", "<C-u>zz", { desc = "Scroll up half a page", silent = true })
map(n, "<C-f>", "<C-f>zz", { desc = "Scroll down a page", silent = true })
map(n, "<C-b>", "<C-b>zz", { desc = "Scroll up a page", silent = true })

-- Search
-- map(n, "-", "/")
map(x, "-", "<Esc>/\\%V", { desc = " Search in sel" })
map(n, "n", "nzz", { desc = "Search next", silent = true })
map(n, "N", "Nzz", { desc = "Search previous", silent = true })
map(ni, "<esc>", "<cmd>nohlsearch<cr><esc>", { desc = "Escape and Clear hlsearch", silent = true })

-- Goto matching parenthesis (`remap` needed to use builtin `MatchIt` plugin)
map(n, "gm", "%", { desc = "󰅪 Goto match", remap = true, silent = true })

-- Open first URL in file
-- map(n, "<A-u>", function()
--             local text = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
--             local url = text:match([[%l%l%l-://[^%s)"'`]+]])
--             if url then
--                     vim.ui.open(url)
--             else
--                     vim.notify("No URL found in file.", vim.log.levels.WARN)
--             end
--     end, { desc = " Open first URL in file", silent = true })

-- make `fF` use `nN` instead of `;,`
map(n, "f", function() nano.fF("f") end, { desc = "f", silent = true })
map(n, "F", function() nano.fF("F") end, { desc = "F", silent = true })

-- Folds
map(n, "zh", "zczz", { desc = "Close current fold", silent = true })
map(n, "zl", "zozz", { desc = "Open current fold", silent = true })
map(n, "<A-z>", "zjzz", { desc = "Goto next fold", silent = true })
map(n, "zj", "zjzz", { desc = "Goto next fold", silent = true })

-- Move to the end of previous word
map(nv, "W", "ge", { desc = "Jump to the end of previous word", silent = true })

-- center Ctrl-o
map(n, "<C-o>", "<C-o>zz", { silent = true })

------------------------------------------------------------------------------------------------------------------------
-- EDITING

-- Undo
map(n, "u", "<cmd>silent undo<CR>zz", { desc = "󰜊 Silent undo", silent = true })
map(n, "U", "<cmd>silent redo<CR>zz", { desc = "󰛒 Silent redo", silent = true })
map(n, "<leader>uu", ":earlier ", { desc = "󰜊 Undo to earlier", silent = true })
map(n, "<leader>ur", function() vim.cmd.later(vim.o.undolevels) end, { desc = "󰛒 Redo all", silent = true })

-- Duplicate
map(n, "<C-w>", function() nano.smartDuplicate() end,
    { desc = "󰲢 Duplicate line", nowait = true, silent = true })

-- Toggles
map(n, "~", "v~", { desc = "󰬴 Toggle char case (w/o moving)", silent = true })
map(n, "<", function() nano.toggleWordCasing() end,
    { desc = "󰬴 Toggle lower/Title case", silent = true })

map(n, ">", function() nano.camelSnakeToggle() end,
    { desc = "󰬴 Toggle camel and snake case", silent = true })

-- Delete trailing character
map(n, "<C-S-x>", function()
            local updatedLine = vim.api.nvim_get_current_line():gsub("%S%s*$", "")
            vim.api.nvim_set_current_line(updatedLine)
    end, { desc = "󱎘 Delete char at EoL", silent = true })

-- Append to EoL
local trailChars = { ",", "\\", "[", "]", "{", "}", ")", ";", "." }
for _, key in pairs(trailChars) do
        local pad = key == "\\" and " " or ""
        map(n, "<leader>" .. key, ("mzA%s%s<Esc>`z"):format(pad, key), { silent = true })
end

-- Whitespace
map(n, "<CR>", "o<Esc>k", { desc = " blank below", silent = true })
map(n, "<S-CR>", "O<Esc>j", { desc = " blank above", silent = true })
map(n, "<A-CR>", "O<Esc>j", { desc = " blank above", silent = true })

-- Merging
map(n, "m", "J", { desc = "󰽜 Merge line up", silent = true })
map(n, "M", "<cmd>. move +1<CR>kJ", { desc = "󰽜 Merge line down", silent = true }) -- `:move` preserves marks

-- Last line
map(n, "G", "Gzz", { desc = "Goto last line", silent = true })

-- Make file executable
map(n, "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- Backspace in INSERT mode
map({ "i", "c" }, "<C-d>", "<Backspace>", { desc = "Delete", silent = true })

-- Save file
vim.keymap.del(i, "<C-s>")
map(ni, "<C-s>", "<cmd>w<CR><esc>", { desc = "Save File", silent = true })
-- map(ni, "<C-s>", "<cmd>wa<CR>", { desc = "Save File", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- SURROUND

map(n, "<A-`>", [[wBi`<Esc>ea`<Esc>b]], { desc = " Inline Code cword", silent = true })
map(x, "<A-`>", "<Esc>`<i`<Esc>`>la`<Esc>", { desc = " Inline Code selection", silent = true })
map(i, "<A-`>", "``<Left>", { desc = " Inline Code", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- TEXTOBJECTS

local textobjRemaps = {
        { "c", "}", "", "curly" },
        { "r", "]", "󰅪", "rectangular" },
        { "m", "W", "󰬞", "WORD" },
        { "q", '"', "", "double" },
        { "z", "'", "", "single" },
        { "e", "`", "", "backtick" },
}
for _, value in pairs(textobjRemaps) do
        ---@diagnostic disable-next-line: unknown-diag-code
        ---@diagnostic disable-next-line: access-invisible
        local remap, original, icon, label = unpack(value)
        map({ "o", "x" }, "i" .. remap, "i" .. original, { desc = icon .. " inner " .. label })
        map({ "o", "x" }, "a" .. remap, "a" .. original, { desc = icon .. " outer " .. label })
end

-- Special remaps
map(o, "J", "2j")
map(n, "<C-Space>", '"_ciw', { desc = "󰬞 change word", silent = true })
map(x, "<C-Space>", '"_c', { desc = "󰒅 change selection", silent = true })
map(n, "<S-Space>", '"_daw', { desc = "󰬞 delete word", silent = true })
map(x, "<S-Space>", '"_d', { desc = "󰬞 delete selection", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- COMMENTS

map(nx, "q", "gc", { desc = "󰆈 Comment operator", remap = true, silent = true })
map(n, "qq", "gcc", { desc = "󰆈 Comment line", remap = true, silent = true })
do
        map(o, "u", "gc", { desc = "󰆈 Multiline comment", remap = true })
        map(n, "guu", "guu") -- prevent `omap u` above from overwriting `guu`
end

map(n, "qw", function() comments.commentHr() end, { desc = "󰆈 Horizontal Divider", silent = true })
map(n, "qy", function() comments.duplicateLineAsComment() end,
    { desc = "󰆈 Duplicate Line as Comment", silent = true })
map(n, "Q", function() comments.addComment("eol") end, { desc = "󰆈 Append Comment", silent = true })
map(n, "qo", function() comments.addComment("below") end, { desc = "󰆈 Comment Below", silent = true })
map(n, "qO", function() comments.addComment("above") end, { desc = "󰆈 Comment Above", silent = true })
map(n, "rq", function()
            vim.cmd(("g/%s/d"):format(vim.fn.escape(vim.fn.substitute(vim.o.commentstring, "%s", "", "g"), "/.*[]~")))
    end, { desc = "󰆈  Delete Comments", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- LSP

--[[ LSP KEYMAPS
map(n, "K", vim.lsp.buf.hover, { desc = "󰏪 Hover Documentation" })
map(n, "J", vim.lsp.buf.signature_help, { desc = "󰏪 Signature Help" })
map(n, ",e", vim.diagnostic.open_float, { desc = "󰨓 Diagnostic Float" })
map(n, ",D", vim.lsp.buf.declaration, { desc = " Goto Declaration" })
map(n, ",d", vim.lsp.buf.definition, { desc = " Goto Definition" })
map(n, ",i", vim.lsp.buf.implementation, { desc = " Goto Implementation" })
map(n, ",I", vim.lsp.buf.incoming_calls, { desc = "Incoming calls" })
map(n, ",c", vim.lsp.buf.code_action, { desc = "󱠀 Code Action" })
map(n, ",a", function() require("functions.quickfix").code_actions() end, { desc = "󱠀 Quickfix" })
map(n, "<leader><leader>c", function() require("tiny-code-action").code_action() end, { desc = "󱠀 Code Action Picker" })
map("<leader>f", vim.lsp.buf.format, { desc = "󰏪 Format Buffer"}) --]]

map(nxcvo, ",", "g", { silent = true })

-- GOTO
-- map(n, ",f", "gf", { desc = "Goto File", silent = true })

--[[ HOVER
do
        map(nx, "K", vim.lsp.buf.hover, { desc = "󰋽 LSP hover" })
        local function scrollLspWin(lines)
                local winid = vim.b.lsp_floating_preview --> stores id of last `vim.lsp`-generated win
                if not winid or not vim.api.nvim_win_is_valid(winid) then return end
                vim.api.nvim_win_call(winid, function()
                        local topline = vim.fn.winsaveview().topline
                        vim.fn.winrestview{ topline = topline + lines }
                end)
        end
        map(n, "<PageDown>", function() scrollLspWin(5) end, { desc = "↓ Scroll LSP window", silent = true })
        map(n, "<PageUp>", function() scrollLspWin(-5) end, { desc = "↑ Scroll LSP window", silent = true })
end --]]

------------------------------------------------------------------------------------------------------------------------
-- INSERT MODE

map(n, "i", function()
            local lineEmpty = vim.trim(vim.api.nvim_get_current_line()) == ""
            return (lineEmpty and [["_cc]] or "i")
    end, { expr = true, desc = "indented i on empty line", silent = true })

-- VISUAL MODE
map(n, "<C-v>", "ggVG", { desc = "select all", silent = true })
map(x, "V", "j", { desc = "repeated `V` selects more lines", silent = true })
map(x, "v", "<C-v>", { desc = "`vv` starts visual block", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- INSPECT & EVAL

map(n, "<leader>ih", vim.show_pos, { desc = " Position at cursor", silent = true })
map(n, "<leader>it", vim.treesitter.inspect_tree, { desc = " TS tree", silent = true })
map(n, "<leader>iq", vim.treesitter.query.edit, { desc = " TS query", silent = true })

map(n, "<leader>il", function() eval.lspCapabilities() end,
    { desc = "󱈄 LSP capabilities", silent = true })
map(n, "<leader>in", function() eval.nodeAtCursor() end,
    { desc = " Node at cursor", silent = true })
map(n, "<leader>ib", function() eval.bufferInfo() end,
    { desc = "󰽙 Buffer info", silent = true })
map(nx, "<leader>ie", function() eval.evalNvimLua() end,
    { desc = " Eval", silent = true })
map(n, "<leader><leader>x", function() eval.runFile() end,
    { desc = "󰜎 Run file", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- WINDOWS

-- Create split
map(n, "<A-w>", "<C-W>czz", { desc = "Delete Window", silent = true })
map(n, "<A-->", "<C-W>szz", { desc = "Split Window Below", silent = true })
map(n, "<A-Bslash>", "<C-W>vzz", { desc = "Split Window Right", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- BUFFERS & FILES

map(n, "<A-r>", vim.cmd.edit, { desc = "󰽙 Reload buffer", silent = true })
map(n, "H", "<cmd>bprevious<cr>zz", { desc = "Prev Buffer", silent = true })
map(n, "L", "<cmd>bnext<cr>zz", { desc = "Next Buffer", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- MACROS

do
        local reg       = "r"
        local toggleKey = "0"
        map(
                "n",
                toggleKey,
                function() nano.startOrStopRecording(toggleKey, reg) end,
                { desc = "󰃽 Start/stop recording", silent = true }
        )
        -- stylua: ignore
        map(n, "c0", function() nano.editMacro(reg) end,
            { desc = "󰃽 Edit recording", silent = true })
        map(n, "9", "@" .. reg, { desc = "󰃽 Play recording", silent = true })
end

------------------------------------------------------------------------------------------------------------------------
-- REFACTORING

map(n, ",n", vim.lsp.buf.rename, { desc = "󰑕 LSP rename", silent = true })

map(n, "<leader>fd", ":global //d<Left><Left>", { desc = " delete matching lines", silent = true })

map(n, "<leader>rc", function() nano.camelSnakeLspRename() end,
    { desc = "󰑕 LSP rename: camel/snake", silent = true })

map(nx, "<leader>qq", function()
            local line        = vim.api.nvim_get_current_line()
            local updatedLine = line:gsub("[\"']", function(q) return (q == [["]] and [[']] or [["]]) end)
            vim.api.nvim_set_current_line(updatedLine)
    end, { desc = " Switch quotes in line", silent = true })

---@param use "spaces"|"tabs"
local function retabber(use)
        vim.bo.expandtab  = use == "spaces"
        vim.bo.shiftwidth = 4
        vim.bo.tabstop    = 4
        vim.cmd.retab{ bang = true }
        vim.notify("Now using " .. use)
end
map(n, "<leader>f<Tab>", function() retabber("tabs") end, { desc = "󰌒 Use Tabs", silent = true })
map(n, "<leader>f<Space>", function() retabber("spaces") end, { desc = "󱁐 Use Spaces", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- TEMPLATE STRINGS

map(i, "<A-t>", function() require("functions.auto-template-str").insertTemplateStr() end,
    { desc = "󰅳 Insert template string", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- OPTION TOGGLING

map(n, "<leader>or", "<cmd>set relativenumber!<CR>", { desc = " Relative line numbers", silent = true })
map(n, "<leader>on", "<cmd>set number!<CR>", { desc = " Line numbers", silent = true })
map(n, "<leader>ow", "<cmd>set wrap!<CR>", { desc = "󰖶 Wrap", silent = true })

map(n, "<leader>od", function()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled)
    end, { desc = "󰋽 Diagnostics" })

map(n, "<leader>oc", function() vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0 end,
    { desc = "󰈉 Conceal", silent = true })

map(n, "<leader>oo", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Toggle IDE stuff", silent = true })

------------------------------------------------------------------------------------------------------------------------
-- RELOAD PLUGINS

map(n, "<leader>lr", function()
            ---@diagnostic disable-next-line: undefined-field
            local plugins      = require("lazy").plugins()
            local plugin_names = {}
            for _, plugin in ipairs(plugins) do
                    table.insert(plugin_names, plugin.name)
            end

            vim.ui.select(
                    plugin_names,
                    { title = "Reload plugin" },
                    function(selected)
                            ---@diagnostic disable-next-line: undefined-field
                            require("lazy").reload({ plugins = { selected } })
                    end
            )
    end, { desc = "Reload plugin", silent = true })
