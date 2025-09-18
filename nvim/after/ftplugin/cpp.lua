--[[ C/C++ SEMANTIC SYNTAX HIGHLIGHTING
vim.cmd(" highlight cBlock                                   guifg=#cdd6f4 ")
vim.cmd(" highlight cRepeat                                  guifg=#74c7ec ")
vim.cmd(" highlight cConditional                             guifg=#74c7ec ")
vim.cmd(" highlight cInclude                                 guifg=#f38ba8 ")

vim.cmd(" highlight @type.builtin.cpp                        guifg=#6c7086 ")
vim.cmd(" highlight @lsp.type.type.cpp                       guifg=#6c7086 ")
vim.cmd(" highlight @keyword.conditional.cpp                 guifg=#74c7ec ")
vim.cmd(" highlight @keyword.repeat.cpp                      guifg=#74c7ec ")
vim.cmd(" highlight @keyword.return.cpp                      guifg=#f38ba8 ")
vim.cmd(" highlight @function.cpp                            guifg=#dce0e8 ")
vim.cmd(" highlight @lsp.type.function.cpp                   guifg=#dce0e8 ")
vim.cmd(" highlight @lsp.type.method.cpp                     guifg=#dce0e8 ")
vim.cmd(" highlight @lsp.type.class.cpp                      guifg=#dce0e8 ")
vim.cmd(" highlight @lsp.type.namespace.cpp                  guifg=#f9e2af ")
vim.cmd(" highlight @lsp.typemod.class.defaultLibrary.cpp    guifg=#f38ba8 ")
vim.cmd(" highlight @lsp.typemod.variable.defaultLibrary.cpp guifg=#f38ba8 ")
vim.cmd(" highlight @lsp.typemod.function.defaultLibrary.cpp guifg=#f38ba8 ")
vim.cmd(" highlight @lsp.typemod.variable.globalScope        guifg=#f38ba8 ")
vim.cmd(" highlight @lsp.typemod.variable.functionScope.cpp  guifg=#cba6f7 ")

vim.api.nvim_set_hl(0, "varGlobScope", { fg = "#fab387" })
vim.api.nvim_set_hl(0, "varFuncScope", { fg = "#b4befe" })
vim.api.nvim_set_hl(0, "varClassScope", { fg = "#74c7ec" })
--]]

--[[ GLOBAL SCOPE
vim.api.nvim_create_autocmd("LspTokenUpdate", {
        callback = function(args)
                local token = args.data.token
                if
                    token.type == "variable"
                    and token.modifiers.globalScope
                    and not token.modifiers.readonly
                    and not token.modifiers.defaultLibrary
                then
                        vim.lsp.semantic_tokens.highlight_token(
                                token, args.buf, args.data.client_id, "varGlobScope")
                end
        end,
})
--]]

--[[ FUNCTION SCOPE
vim.api.nvim_create_autocmd("LspTokenUpdate", {
        callback = function(args)
                local token = args.data.token
                if
                           token.type == "variable"
                           and token.modifiers.functionScope
                           and not token.modifiers.readonly
                           and not token.modifiers.readonly
                then
                        vim.lsp.semantic_tokens.highlight_token(
                                token, args.buf, args.data.client_id, "varFuncScope")
                end
        end,
})
--]]

--[[ CLASS SCOPE
vim.api.nvim_create_autocmd("LspTokenUpdate", {
        callback = function(args)
                local token = args.data.token
                if
                           token.type == "constructor"
                           and token.modifiers.identifier
                           and not token.modifiers.readonly
                then
                        vim.lsp.semantic_tokens.highlight_token(
                                token, args.buf, args.data.client_id, "varClassScope")
                end
        end,
})
--]]
