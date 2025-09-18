local M = {}

M.extraTextobjMaps = {
        func      = "f",
        call      = "l",
        condition = "o",
        wikilink  = "R",
}

---ensures unique keymaps https://www.reddit.com/r/neovim/comments/16h2lla/can_you_make_neovim_warn_you_if_your_config_maps/
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? {desc?: string, unique?: boolean, buffer?: number|boolean, remap?: boolean, silent?:boolean, nowait?: boolean}
function M.uniqueKeymap(mode, lhs, rhs, opts)
        if not opts then opts = {} end
        if opts.unique == nil then opts.unique = true end -- allows to disable with `unique=false`

        -- violating `unique=true` throws an error; using `pcall` so other mappings
        -- are still loaded
        pcall(vim.keymap.set, mode, lhs, rhs, opts)
end

---sets `buffer`, `silent` and `nowait` to true
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? {desc?: string, unique?: boolean, buffer?: number|boolean, remap?: boolean, silent?:boolean, nowait?: boolean}
function M.bufKeymap(mode, lhs, rhs, opts)
        opts = vim.tbl_extend("force", { buffer = true, silent = true, nowait = true }, opts or {})
        vim.keymap.set(mode, lhs, rhs, opts)
end

---@param text string
---@param replace string
function M.bufAbbrev(text, replace) vim.keymap.set("ia", text, replace, { buffer = true }) end

function M.clientHas(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
end

function M.safeQuit()
        for _, buf in pairs(vim.api.nvim_list_bufs()) do
                if vim.bo[buf].buftype == "terminal" and vim.fn.bufloaded(buf) == 1 then
                        local pid    = vim.b[buf].terminal_job_pid
                        local handle = io.popen("pgrep -P " .. pid)

                        if handle ~= nil then
                                local child_pids_string = handle:read("*a")
                                handle:close()
                                if #child_pids_string > 0 then
                                        vim.api.nvim_echo(
                                                { { vim.fn.bufname(buf) .. " has running process", "ErrorMsg" } },
                                                false, {})
                                        return
                                end
                        end
                end
        end
        for _, arg in ipairs(vim.v.argv) do
                if arg == "--embed" then
                        vim.cmd.quit()
                        return
                end
        end
        vim.cmd.detatch()
end

--------------------------------------------------------------------------------
return M
