return
{
        "mikavilpas/yazi.nvim",
        lazy  = true,
        keys  = {
                {
                        "<leader><leader>y",
                        mode = { "n", "v" },
                        "<cmd>Yazi<cr>",
                        desc = "Open yazi at the current file",
                },
                {
                        "<leader>yw",
                        "<cmd>Yazi cwd<cr>",
                        desc = "Open the file manager in nvim's working directory",
                },
        },
        opts  = {
                open_for_directories = false,
                keymaps              = {
                        show_help = "<f1>",
                },
        },
}
