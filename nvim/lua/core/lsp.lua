------------------------------------------------------------------------------------------------------------------------
-- LSP SERVERS

local capabilities = {
        textDocument = {
                foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly     = true,
                },
        },
}

vim.lsp.config("*", {
        root_markers = { ".git" },
})

vim.lsp.enable({
        -- "asm",
        -- "basedpyright",
        "bashls",
        "clangd",
        "cssls",
        "css_variables",
        "emmet",
        -- "emmylua_ls",
        "glsl_analyzer",
        "ts_ls",
        "gopls",
        "jsonls",
        "lua_ls",
        "yamlls",
        -- "pylsp",
        -- "pylyzer",
        "pyright",
        "ruff",
        "rust_analyzer",
        "superhtml",
})

vim.api.nvim_create_autocmd("FileType", {
        pattern  = "go",
        callback = function()
                local root = vim.fs.dirname(vim.fs.find({ "go.work", "go.mod", ".git" }, { upward = true })[1])
                if not root then return end

                local settings_path  = root .. "/gopls.json" or "/gopls.jsonc"

                local gopls_settings = {}
                local stat           = vim.uv.fs_stat(settings_path)
                if stat and stat.type == "file" then
                        local ok, parsed = pcall(function()
                                return vim.fn.json_decode(vim.fn.readfile(settings_path))
                        end)
                        if ok then gopls_settings = parsed end
                end

                vim.lsp.start({
                        name     = "gopls",
                        cmd      = { "gopls" },
                        root_dir = root,
                        settings = { gopls = gopls_settings },
                })
        end,
})


------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTICS

---@diagnostic disable-next-line: unused-local
local icons   = require("core.icons").diagnostics
local numbers = {
        text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN]  = "",
                [vim.diagnostic.severity.INFO]  = "",
                [vim.diagnostic.severity.HINT]  = "",
        },

        numhl = {
                [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                [vim.diagnostic.severity.WARN]  = "WarningMsg",
                [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
                [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
        },
}

vim.diagnostic.config{
        signs            = numbers,
        jump             = { float = false },
        virtual_text     = false,
        update_in_insert = false,
        severity_sort    = true,
}

------------------------------------------------------------------------------------------------------------------------
-- HANDLERS

-- `vim.lsp.buf.rename`: add notification & writeall to renaming
local originalRenameHandler             = vim.lsp.handlers["textDocument/rename"]
vim.lsp.handlers["textDocument/rename"] = function(err, result, ctx, config)
        originalRenameHandler(err, result, ctx, config)
        if err or not result then return end

        -- count changes
        local changes = result.changes or result.documentChanges or {}
        local changedFiles = vim.iter(vim.tbl_keys(changes))
                   :filter(function(file) return #changes[file] > 0 end)
                   :map(function(file) return "- " .. vim.fs.basename(file) end)
                   :totable()
        local changeCount = 0
        for _, change in pairs(changes) do
                changeCount = changeCount + #(change.edits or change)
        end

        -- notification
        local pluralS = changeCount > 1 and "s" or ""
        local msg = ("[%d] instance%s"):format(changeCount, pluralS)
        if #changedFiles > 1 then
                msg = ("**%s in [%d] files**\n%s"):format(
                        msg,
                        #changedFiles,
                        table.concat(changedFiles, "\n")
                )
        end
        vim.notify(msg, nil, { title = "Renamed with LSP", icon = "󰑕" })

        -- save all
        if #changedFiles > 1 then vim.cmd.wall() end
end

local hover                             = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover                       = function()
        return hover{
                border     = { " ", " ", " ", " ", " ", " ", " ", " " },
                title      = "Hover",
                wrap       = false,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width  = math.floor(vim.o.columns * 0.6),
        }
end

local signature_help                    = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help              = function()
        return signature_help{
                border     = { " ", " ", " ", " ", " ", " ", " ", " " },
                title      = "Signature Help",
                wrap       = false,
                max_height = math.floor(vim.o.lines * 0.5),
                max_width  = math.floor(vim.o.columns * 0.6),
        }
end

------------------------------------------------------------------------------------------------------------------------
-- LSP PROGRESS

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress                          = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local value  = ev.data.params
                           .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
                if not client or type(value) ~= "table" then
                        return
                end
                local p = progress[client.id]

                for i = 1, #p + 1 do
                        if i == #p + 1 or p[i].token == ev.data.params.token then
                                p[i] = {
                                        token = ev.data.params.token,
                                        msg   = ("[%3d%%] %s%s"):format(
                                                value.kind == "end" and 100 or value.percentage or 100,
                                                value.title or "",
                                                value.message and (" **%s**"):format(value.message) or ""
                                        ),
                                        done  = value.kind == "end",
                                }
                                break
                        end
                end

                local msg = {} ---@type string[]
                progress[client.id] = vim.tbl_filter(function(v)
                                                             return table.insert(msg, v.msg) or not v.done
                                                     end, p)

                local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                vim.notify(table.concat(msg, "\n"), "info", {
                        id    = "lsp_progress",
                        title = client.name,
                        opts  = function(notif)
                                notif.icon = #progress[client.id] == 0 and "■"
                                           or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end,
                })
        end,
})

-- vim.lsp.document_color.enable()
-- vim.lsp.linked_editing_range(true, {})
