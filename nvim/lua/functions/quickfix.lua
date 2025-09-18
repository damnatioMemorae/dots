local M = {}
--------------------------------------------------------------------------------

function M.code_actions()
        local function apply_specific_code_action(res)
                vim.lsp.buf.code_action({
                        filter = function(action)
                                return action.title == res.title
                        end,
                        apply  = true,
                })
        end

        local actions                  = {}

        actions["Goto Definition"]     = { priority = 100, call = vim.lsp.buf.definition }
        actions["Goto Implementation"] = { priority = 200, call = vim.lsp.buf.implementation }
        actions["Show References"]     = { priority = 300, call = vim.lsp.buf.references }
        actions["Rename"]              = { priority = 400, call = vim.lsp.buf.rename }

        local bufnr                    = vim.api.nvim_get_current_buf()
        local params                   = vim.lsp.util.make_range_params()

        params.context                 = {
                triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
                diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
        }

        vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(_, results, _, _)
                if not results or #results == 0 then
                        return
                end
                for i, res in ipairs(results) do
                        local prio = 10
                        if res.isPreferred then
                                if res.kind == "quickfix" then
                                        prio = 0
                                else
                                        prio = 1
                                end
                        end
                        actions[res.title] = {
                                priority = prio,
                                call = function()
                                        apply_specific_code_action(res)
                                end,
                        }
                end
                local items = {}
                for t, action in pairs(actions) do
                        table.insert(items, { title = t, priority = action.priority })
                end
                table.sort(items, function(a, b)
                        return a.priority < b.priority
                end)
                local titles = {}
                for _, item in ipairs(items) do
                        table.insert(titles, item.title)
                end
                vim.ui.select(titles, {}, function(choice)
                        if choice == nil then
                                return
                        end
                        actions[choice].call()
                end)
        end)
end

--------------------------------------------------------------------------------
return M
