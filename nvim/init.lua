-- FIX: broken `:Inspect` https://github.com/neovim/neovim/issues/31675
-- can be removed on the version after 0.10.3

vim.hl                = vim.highlight

vim.g.projects_dir    = vim.env.HOME .. '/dev/'

------------------------------------------------------------------------------------------------------------------------
-- CONFIG

vim.g.mapleader       = " "
vim.g.maplocalleader  = "<Nop>"
-- vim.g.borderStyle    = "single"
vim.g.borderStyle     = { " ", " ", " ", " ", " ", " ", " ", " " }
vim.g.borderStyleNone = "none"
vim.g.backdrop        = 80
vim.g.blend           = 0
vim.g.winblend        = 20
vim.g.localRepos      = vim.fs.normalize("$HOME/dev/")

------------------------------------------------------------------------------------------------------------------------

---@param module string
local function safeRequire(module)
        local success, errmsg = pcall(require, module)
        if not success then
                local msg = ("Error loading `%s`: %s"):format(module, errmsg)
                vim.defer_fn(function() vim.notify(msg, vim.log.levels.ERROR) end, 1000)
        end
end

safeRequire("core.options")

if not vim.env.NO_PLUGINS then
        -- INFO only load plugins when `NO_PLUGINS` is not set.
        -- This is for security reasons, e.g., when editing a password with `pass`.
        safeRequire("core.lazy")
        if vim.g.setColorscheme then vim.g.setColorscheme("init") end
end

safeRequire("core.commands")
safeRequire("core.autocmds")
-- safeRequire("core.diagnostics")
safeRequire("core.lsp")
safeRequire("core.keymaps")
safeRequire("core.yank-paste")
safeRequire("functions.quickfix")
safeRequire("core.backdrop-underline-fix")
safeRequire("functions.beacon")
-- safeRequire("core.fold")

if os.getenv("DISPLAY") ~= nil or os.getenv("WAYLAND_DISPLAY") ~= nil then
        -- vim.cmd("colorscheme darkmatter")
        vim.cmd("colorscheme catppuccin")
else
        vim.cmd("colorscheme industry")
end
