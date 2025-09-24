local api = vim.api

------------------------------------------------------------------------------------------------------------------------
-- AUTO-CD TO PROJECT ROOT

--[[
local autoCdConfig = {
        childOfRoot = {
                ".git",
        },
        parentOfRoot = {
                ".config",
                vim.fs.basename(vim.env.HOME),
        },
}
api.nvim_create_autocmd("VimEnter", {
        desc     = "User: Auto-cd to project root",
        callback = function(ctx)
                local root = vim.fs.root(ctx.buf, function(name, path)
                        local parentName         = vim.fs.basename(vim.fs.dirname(path))
                        local dirHasParentMarker = vim.tbl_contains(autoCdConfig.parentOfRoot, parentName)
                        local dirHasChildMarker  = vim.tbl_contains(autoCdConfig.childOfRoot, name)
                        return dirHasChildMarker or dirHasParentMarker
                end)
                if root and root ~= "" then vim.uv.chdir(root) end
        end,
})
--]]

------------------------------------------------------------------------------------------------------------------------
-- <q>

api.nvim_create_autocmd("FileType", {
        group    = api.nvim_create_augroup("Close with <q>", { clear = true }),
        pattern  = {
                "PlenaryTestPopup",
                "help",
                "lspinfo",
                "man",
                "notify",
                "qf",
                "spectre_panel",
                "startuptime",
                "tsplayground",
                "neotest-output",
                "checkhealth",
                "neotest-summary",
                "neotest-output-panel",
        },
        callback = function(event)
                vim.bo[event.buf].buflisted = false
                vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- RESIZE NEOVIM WHEN TERMINAL IS RESIZED

api.nvim_command("autocmd VimResized * wincmd =")

------------------------------------------------------------------------------------------------------------------------

api.nvim_create_autocmd("FocusGained", {
        desc     = "User: FIX `cwd` being not available when it is deleted outside nvim.",
        callback = function()
                if not vim.uv.cwd() then vim.uv.chdir("/") end
        end,
})

api.nvim_create_autocmd("FocusGained", {
        desc     = "User: Close all non-existing buffers on `FocusGained`.",
        callback = function()
                local closedBuffers = {}
                local allBufs       = vim.fn.getbufinfo{ buflisted = 1 }
                vim.iter(allBufs):each(function(buf)
                        if not api.nvim_buf_is_valid(buf.bufnr) then return end
                        local stillExists   = vim.uv.fs_stat(buf.name) ~= nil
                        local specialBuffer = vim.bo[buf.bufnr].buftype ~= ""
                        local newBuffer     = buf.name == ""
                        if stillExists or specialBuffer or newBuffer then return end
                        table.insert(closedBuffers, vim.fs.basename(buf.name))
                        api.nvim_buf_delete(buf.bufnr, { force = false })
                end)
                if #closedBuffers == 0 then return end

                if #closedBuffers == 1 then
                        vim.notify(closedBuffers[1], nil, { title = "Buffer closed", icon = "󰅗" })
                else
                        local text = "- " .. table.concat(closedBuffers, "\n- ")
                        vim.notify(text, nil, { title = "Buffers closed", icon = "󰅗" })
                end

                -- If ending up in empty buffer, re-open the first oldfile that exists
                vim.defer_fn(function()
                                     if api.nvim_buf_get_name(0) ~= "" then return end
                                     for _, file in ipairs(vim.v.oldfiles) do
                                             if vim.uv.fs_stat(file) and vim.fs.basename(file) ~= "COMMIT_EDITMSG" then
                                                     vim.cmd.edit(file)
                                                     return
                                             end
                                     end
                             end, 1)
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- AUTO-NOHL & INLINE SEARCH COUNT

---@param mode? "clear"
local function searchCountIndicator(mode)
        local signColumnPlusScrollbarWidth = 2 + 3

        local countNs                      = api.nvim_create_namespace("searchCounter")
        api.nvim_buf_clear_namespace(0, countNs, 0, -1)
        if mode == "clear" then return end

        local row   = api.nvim_win_get_cursor(0)[1]
        local count = vim.fn.searchcount()
        if count.total == 0 then return end
        local text     = (" %d/%d "):format(count.current, count.total)
        local line     = api.nvim_get_current_line():gsub("\t", (" "):rep(vim.bo.shiftwidth))
        local lineFull = #line + signColumnPlusScrollbarWidth >= api.nvim_win_get_width(0)
        local margin   = { (" "):rep(lineFull and signColumnPlusScrollbarWidth or 0) }

        api.nvim_buf_set_extmark(0, countNs, row - 1, 0, {
                virt_text     = { { text, "IncSearch" }, margin },
                virt_text_pos = lineFull and "right_align" or "eol",
                priority      = 200,
        })
end

-- without the `searchCountIndicator`, this `on_key` simply does `auto-nohl`
vim.on_key(function(key, _typed)
                   key                   = vim.fn.keytrans(key)
                   local isCmdlineSearch = vim.fn.getcmdtype():find("[/?]") ~= nil
                   local isNormalMode    = api.nvim_get_mode().mode == "n"
                   local searchStarted   = (key == "/" or key == "?") and isNormalMode
                   local searchConfirmed = (key == "<CR>" and isCmdlineSearch)
                   local searchCancelled = (key == "<Esc>" and isCmdlineSearch)
                   if not (searchStarted or searchConfirmed or searchCancelled or isNormalMode) then return end

                   -- works for RHS, therefore no need to consider remaps
                   local searchMovement = vim.tbl_contains({ "n", "N", "*", "#" }, key)
                   local shortPattern   = vim.fn.getreg("/"):gsub([[\V\C]], ""):len() <= 1 -- for `fF` function

                   if searchCancelled or (not searchMovement and not searchConfirmed) then
                           vim.opt.hlsearch = false
                           searchCountIndicator("clear")
                   elseif (searchMovement and not shortPattern) or searchConfirmed or searchStarted then
                           vim.opt.hlsearch = true
                           vim.defer_fn(searchCountIndicator, 1)
                   end
           end, api.nvim_create_namespace("autoNohlAndSearchCount"))

------------------------------------------------------------------------------------------------------------------------
-- SKELETONS (TEMPLATES)

-- CONFIG
local templateDir       = vim.fn.stdpath("config") .. "/templates"
local globToTemplateMap = {
        [vim.g.localRepos .. "/**/*.lua"]                    = "module.lua",
        [vim.fn.stdpath("config") .. "/lua/functions/*.lua"] = "module.lua",
        [vim.fn.stdpath("config") .. "/lua/plugins/*.lua"]   = "plugin-spec.lua",
        [vim.fn.stdpath("config") .. "/lsp/*.lua"]           = "lsp.lua",

        -- ["**/*.py"]                                          = "template.py",
        ["**/*.sh"]                                          = "template.zsh",
        ["**/*.*sh"]                                         = "template.zsh",
}

api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
        desc     = "User: Apply templates (`BufReadPost` for files created outside of nvim.)",
        callback = function(ctx)
                vim.defer_fn(
                        function()                                              -- defer, to ensure new files are written
                                local stats = vim.uv.fs_stat(ctx.file)
                                if not stats or stats.size > 10 then return end -- 10 bytes for file metadata
                                local filepath, bufnr = ctx.file, ctx.buf

                                -- determine template from glob
                                local matchedGlob = vim.iter(globToTemplateMap):find(function(glob)
                                        local globMatchesFilename = vim.glob.to_lpeg(glob):match(filepath)
                                        return globMatchesFilename
                                end)
                                if not matchedGlob then return end
                                local templateFile = globToTemplateMap[matchedGlob]
                                local templatePath = vim.fs.normalize(templateDir .. "/" .. templateFile)
                                if not vim.uv.fs_stat(templatePath) then return end

                                -- read template & move to cursor placeholder
                                local content = {}
                                local cursor
                                local row = 1
                                for line in io.lines(templatePath) do
                                        local placeholderPos = line:find("%$0")
                                        if placeholderPos then
                                                line = line:gsub("%$0", "")
                                                cursor = { row, placeholderPos - 1 }
                                        end
                                        table.insert(content, line)
                                        row = row + 1
                                end
                                api.nvim_buf_set_lines(0, 0, -1, false, content)
                                if cursor then api.nvim_win_set_cursor(0, cursor) end

                                -- adjust filetype if needed (e.g. when applying a zsh template to .sh files)
                                local newFt = vim.filetype.match{ buf = bufnr }
                                if vim.bo[bufnr].ft ~= newFt then vim.bo[bufnr].ft = newFt end
                        end, 100)
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- ENFORCE SCROLLOFF AT EOF

api.nvim_create_autocmd("CursorMoved", {
        desc     = "User: Enforce scrolloff at EoF",
        callback = function(ctx)
                if vim.bo[ctx.buf].buftype ~= "" then return end

                local winHeight           = api.nvim_win_get_height(0)
                local visualDistanceToEof = winHeight - vim.fn.winline()
                local scrolloff           = math.min(vim.o.scrolloff, math.floor(winHeight / 2))

                if visualDistanceToEof < scrolloff then
                        local topline = vim.fn.winsaveview().topline
                        -- topline is inaccurate if it is a folded line, thus add number of folded lines
                        local toplineFoldAmount = vim.fn.foldclosedend(topline) - vim.fn.foldclosed(topline)
                        topline = topline + toplineFoldAmount
                        vim.fn.winrestview{ topline = topline + scrolloff - visualDistanceToEof }
                end
        end,
})

-- FIX: for some reason `scrolloff` sometimes being set to `0` on new buffers
local originalScrolloff = vim.o.scrolloff
api.nvim_create_autocmd({ "BufReadPost", "BufNew" }, {
        desc     = "User: FIX scrolloff on entering new buffer",
        callback = function(ctx)
                vim.defer_fn(function()
                                     if not api.nvim_buf_is_valid(ctx.buf) or vim.bo[ctx.buf].buftype ~= "" then return end
                                     if vim.o.scrolloff == 0 then
                                             vim.o.scrolloff = originalScrolloff
                                             vim.notify("Triggered by [" .. ctx.event .. "]", nil,
                                                        { title = "Scrolloff fix" })
                                     end
                             end, 150)
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- STAY IN CMD

api.nvim_create_autocmd("CmdwinEnter", {
        group    = api.nvim_create_augroup("mariasolos/execute_cmd_and_stay", { clear = true }),
        desc     = "Execute command and stay in the command-line window",
        callback = function(args)
                vim.keymap.set({ "n", "i" }, "<S-CR>", "<cr>q:", { buffer = args.buf })
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- DOCUMENT HIGHLIGHTING

api.nvim_create_autocmd("LspAttach", {
        group    = api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(args)
                ---@param keys string
                ---@param func string|function
                ---@param desc string
                local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
                end

                vim.keymap.set("n", ",", "gr", {})
                map("K", vim.lsp.buf.hover, "󰏪 Hover Documentation")
                map("J", vim.lsp.buf.signature_help, "󰏪 Signature Help")
                -- map("gD", vim.lsp.buf.declaration, " Goto Declaration")
                -- map("gd", vim.lsp.buf.definition, " Goto Definition")
                map("gri", vim.lsp.buf.implementation, " Goto Implementation")
                map("grr", vim.lsp.buf.references, " Goto Implementation")
                map("grI", vim.lsp.buf.incoming_calls, "Incoming calls")
                map("grc", vim.lsp.buf.code_action, "󱠀 Code Action")
                map("gra", function() require("functions.quickfix").code_actions() end, "󱠀 Quickfix")
                map("gr ", function() require("tiny-code-action").code_action() end, "󱠀 Code Action Picker")
                map("gre", vim.diagnostic.open_float, "■ Diagnostic Float")
                map("<A-d>", function()
                            -- vim.diagnostic.goto_next({ float = false })
                            vim.diagnostic.jump({ count = 1, float = false })
                            vim.cmd.normal("zz")
                    end, "■ Diagnostic Next")
                map("<A-D>", function()
                            vim.diagnostic.jump({ count = -1, float = false })
                            vim.cmd.normal("zz")
                    end, "■ Diagnostic Prev")

                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                if vim.fn.has("nvim-0.11") == 1 and client:supports_method("textDocument/documentHighlight") then
                        local highlight_augroup = api.nvim_create_augroup("lsp-highlight", { clear = false })

                        api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                buffer   = args.buf,
                                group    = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                        })

                        api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                buffer   = args.buf,
                                group    = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                        })

                        api.nvim_create_autocmd("LspDetach", {
                                group    = api.nvim_create_augroup("lsp-detach", { clear = true }),
                                callback = function(event2)
                                        vim.lsp.buf.clear_references()
                                        -- api.nvim_clear_autocmd({ "lsp-highlight", buffer = event2.buf })
                                end,
                        })
                end
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- CODELENS

api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                if vim.fn.has("nvim-0.11") == 1 and client:supports_method("textDocument/documentHighlight") then
                        api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                                callback = function()
                                        vim.lsp.codelens.refresh({ bufnr = 0 })
                                end,
                        })
                end
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- SMART VIRTUAL EDITING

api.nvim_create_autocmd("ModeChanged", {
        pattern  = "*:*",
        callback = function()
                local mode = vim.fn.mode()
                if mode == "n" or mode == "\22" then vim.opt.virtualedit = "all" end
                if mode == "i" then vim.opt.virtualedit = "block" end
                if mode == "v" or mode == "V" then vim.opt.virtualedit = "onemore" end
        end,
})

------------------------------------------------------------------------------------------------------------------------
-- SWITCH BETWEEN `rlnu` and `lnu`

api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
        pattern = "*",
        command = "if &nu && mode() != 'i' | set rnu | endif",
})

api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
        pattern = "*",
        command = "if &nu | set nornu | endif",
})
