-- vim.cmd[[highpight Pmenu ctermbg=black guibg=black]]
--// vim.g.material_style = "deep ocean"

vim.cmd [[colorscheme catppuccin-macchiato]]
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
      hi EndOfBuffer guibg=NONE ctermbg=NONE
      hi VertSplit guibg=NONE ctermbg=NONE
      hi LineNr guibg=NONE ctermbg=NONE
      hi CursorLineNr guibg=NONE ctermbg=NONE
      hi SignColumn guibg=NONE ctermbg=NONE
      hi FoldColumn guibg=NONE ctermbg=NONE
      hi Folded guibg=NONE ctermbg=NONE
      hi StatusLine guibg=NONE ctermbg=NONE
      hi StatusLineNC guibg=NONE ctermbg=NONE
      hi TabLine guibg=NONE ctermbg=NONE
      hi TabLineFill guibg=NONE ctermbg=NONE
      hi TabLineSel guibg=NONE ctermbg=NONE
      hi WinSeparator guibg=NONE ctermbg=NONE

      hi Visual guibg=#000000 guifg=NONE gui=bold ctermbg=Black ctermfg=NONE cterm=bold
      hi VisualNOS guibg=NONE ctermbg=NONE
      hi PmenuSel guibg=NONE ctermbg=NONE
      hi Search guibg=NONE ctermbg=NONE
      hi IncSearch guibg=NONE ctermbg=NONE
      hi CurSearch guibg=NONE ctermbg=NONE

      hi NormalFloat guibg=NONE ctermbg=NONE
      hi FloatBorder guibg=NONE ctermbg=NONE
      hi FloatTitle guibg=NONE ctermbg=NONE
      hi Pmenu guibg=NONE ctermbg=NONE
      hi PmenuSbar guibg=NONE ctermbg=NONE
      hi PmenuThumb guibg=NONE ctermbg=NONE

      hi LspInfoBorder guibg=NONE ctermbg=NONE
      hi DiagnosticFloatingError guibg=NONE ctermbg=NONE
      hi DiagnosticFloatingWarn guibg=NONE ctermbg=NONE
      hi DiagnosticFloatingInfo guibg=NONE ctermbg=NONE
      hi DiagnosticFloatingHint guibg=NONE ctermbg=NONE
      hi DiagnosticSignError guibg=NONE ctermbg=NONE
      hi DiagnosticSignWarn guibg=NONE ctermbg=NONE
      hi DiagnosticSignInfo guibg=NONE ctermbg=NONE
      hi DiagnosticSignHint guibg=NONE ctermbg=NONE

      hi LspSignatureActiveParameter guibg=NONE ctermbg=NONE
      hi LspCodeLens guibg=NONE ctermbg=NONE
      hi LspCodeLensSeparator guibg=NONE ctermbg=NONE

      hi TelescopeNormal guibg=NONE ctermbg=NONE
      hi TelescopeBorder guibg=NONE ctermbg=NONE
      hi TelescopePromptNormal guibg=NONE ctermbg=NONE
      hi TelescopePromptBorder guibg=NONE ctermbg=NONE
      hi TelescopeResultsNormal guibg=NONE ctermbg=NONE
      hi TelescopeResultsBorder guibg=NONE ctermbg=NONE
      hi TelescopePreviewNormal guibg=NONE ctermbg=NONE
      hi TelescopePreviewBorder guibg=NONE ctermbg=NONE

      hi CmpDocumentation guibg=NONE ctermbg=NONE
      hi CmpDocumentationBorder guibg=NONE ctermbg=NONE

      hi NotifyBackground guibg=NONE ctermbg=NONE
      hi MiniCompletionActiveParameter guibg=NONE ctermbg=NONE
    ]]
  end
})

vim.cmd [[colorscheme catppuccin-macchiato]]
