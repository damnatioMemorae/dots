local function highlight(tag, foreground, background, style)
  vim.cmd("highlight " .. tag .. " guifg=" .. foreground .. " guibg=" .. background .. " gui=" .. style)
end

-- INFO: Catppuccin
highlight("StatusMode", "#11111b", "#cdd6f4", "bold")
highlight("StatusBranch", "#cdd6f4", "#11111b", "NONE")
highlight("StatusBranchChanges", "#45475a", "#11111b", "NONE")
highlight("StatusFile", "#45475a", "#11111b", "NONE")
highlight("StatusSaved", "#a6adc8", "#11111b", "NONE")

highlight("StatusWarnings", "#f9e2b0", "#11111b", "NONE")
highlight("StatusErrors", "#f38ba8", "#11111b", "NONE")
highlight("StatusInfos", "#89dcec", "#11111b", "NONE")
highlight("BranchComponentStatus", "#45475a", "#11111b", "NONE")

-- INFO: Gruvbox

-- highlight("StatusMode", "#282828", "#fbf1c7", "bold")
-- highlight("StatusBranch", "#fbf1c7", "#282828", "NONE")
-- highlight("StatusBranchChanges", "#665c54", "#282828", "NONE")
-- highlight("StatusFile", "#665c54", "#282828", "NONE")
-- highlight("StatusSaved", "#928374", "#282828", "NONE")
-- highlight("StatusWarnings", "#fabd2f", "#282828", "NONE")
-- highlight("StatusErrors", "#fb4934", "#282828", "NONE")
-- highlight("StatusInfos", "#83a598", "#282828", "NONE")
-- highlight("BranchComponentStatus", "#665c54", "#282828", "NONE")
