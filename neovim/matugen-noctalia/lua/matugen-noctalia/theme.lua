local M = {}

local function to_rgb(hex)
    hex = hex:gsub("#", "")
    return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function blend(fg, bg, a)
    local fr, fgr, fb = to_rgb(fg)
    local br, bgr, bb = to_rgb(bg)
    local function mix(x, y)
        return math.floor(x * a + y * (1 - a) + 0.5)
    end
    return string.format("#%02x%02x%02x", mix(fr, br), mix(fgr, bgr), mix(fb, bb))
end

local function is_dark(hex)
    local r, g, b = to_rgb(hex)
    return (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255 < 0.5
end

function M.get()
    local c = require("matugen-generated")
    local dark = is_dark(c.background)
    vim.o.background = dark and "dark" or "light"

    local function harmonize(hex)
        return blend(hex, c.primary, 0.78)
    end
    local green = harmonize(dark and "#8fd694" or "#2f7d3a")
    local yellow = harmonize(dark and "#e8c872" or "#8a6a00")
    local orange = harmonize(dark and "#f2a477" or "#b2511a")

    local accent = blend(c.primary, c.secondary, 0.5)
    local violet = blend(c.tertiary, c.primary, 0.6)
    local prop = blend(c.primary, c.on_background, 0.55)
    local param = blend(c.tertiary, c.on_background, 0.5)

    local bg_dim = blend(c.surface_container, c.background, 0.45)
    local cursorline = blend(c.surface_container, c.background, 0.7)
    local selection = blend(c.primary_container, c.background, 0.85)
    local indent = blend(c.outline_variant, c.background, 0.55)
    local indent_act = blend(c.primary, c.background, 0.45)

    local diff_add = blend(green, c.background, 0.16)
    local diff_del = blend(c.error, c.background, 0.16)
    local diff_change = blend(c.primary, c.background, 0.14)
    local diff_text = blend(c.primary, c.background, 0.30)
    local function tint(color, a)
        return blend(color, c.background, a or 0.12)
    end

    local transparent = vim.g.matugen_transparent == true
    local bg = transparent and "NONE" or c.background
    local float = transparent and "NONE" or c.surface_container
    local side = transparent and "NONE" or bg_dim

    local g = {
        Normal = { fg = c.on_background, bg = bg },
        NormalNC = { link = "Normal" },
        NormalFloat = { fg = c.on_surface, bg = float },
        FloatBorder = { fg = c.outline, bg = float },
        FloatTitle = { fg = c.primary, bg = float, bold = true },
        FloatFooter = { fg = c.on_surface_variant, bg = float },
        Cursor = { fg = c.on_primary, bg = c.primary },
        lCursor = { link = "Cursor" },
        TermCursor = { link = "Cursor" },
        CursorLine = { bg = cursorline },
        CursorColumn = { link = "CursorLine" },
        ColorColumn = { bg = cursorline },
        CursorLineNr = { fg = c.primary, bold = true },
        LineNr = { fg = c.outline_variant },
        SignColumn = { fg = c.outline_variant, bg = bg },
        FoldColumn = { fg = c.outline_variant, bg = bg },
        Folded = { fg = c.on_surface_variant, bg = c.surface_container },
        Conceal = { fg = c.outline },
        NonText = { fg = indent },
        Whitespace = { fg = indent },
        SpecialKey = { fg = indent },
        EndOfBuffer = { fg = bg },
        Directory = { fg = c.primary },
        Title = { fg = c.primary, bold = true },
        Visual = { bg = selection },
        VisualNOS = { link = "Visual" },
        Search = { fg = c.on_surface, bg = c.secondary_container },
        CurSearch = { fg = c.on_primary, bg = c.primary, bold = true },
        IncSearch = { fg = c.on_primary, bg = c.primary },
        Substitute = { fg = c.on_error, bg = c.error },
        MatchParen = { fg = c.tertiary, bg = c.surface_container_high, bold = true },
        QuickFixLine = { bg = c.surface_container_high, bold = true },
        WinSeparator = { fg = c.outline_variant, bg = "NONE" },
        VertSplit = { link = "WinSeparator" },
        WinBar = { fg = c.on_surface_variant, bg = bg },
        WinBarNC = { fg = c.outline, bg = bg },
        SpellBad = { undercurl = true, sp = c.error },
        SpellCap = { undercurl = true, sp = yellow },
        SpellLocal = { undercurl = true, sp = c.secondary },
        SpellRare = { undercurl = true, sp = c.tertiary },

        StatusLine = { fg = c.on_surface, bg = c.surface_container },
        StatusLineNC = { fg = c.outline, bg = bg_dim },
        TabLine = { fg = c.on_surface_variant, bg = c.surface_container },
        TabLineSel = { fg = c.on_primary_container, bg = c.primary_container, bold = true },
        TabLineFill = { bg = bg_dim },
        MsgArea = { fg = c.on_surface_variant },
        ModeMsg = { fg = c.primary, bold = true },
        MsgSeparator = { link = "WinSeparator" },
        ErrorMsg = { fg = c.error, bold = true },
        WarningMsg = { fg = yellow },
        MoreMsg = { fg = green },
        Question = { fg = c.secondary },

        Pmenu = { fg = c.on_surface, bg = float },
        PmenuSel = { fg = c.on_primary_container, bg = c.primary_container, bold = true },
        PmenuKind = { fg = c.secondary, bg = float },
        PmenuKindSel = { fg = c.on_primary_container, bg = c.primary_container },
        PmenuExtra = { fg = c.outline, bg = float },
        PmenuExtraSel = { fg = c.on_primary_container, bg = c.primary_container },
        PmenuSbar = { bg = c.surface_container_high },
        PmenuThumb = { bg = c.outline },
        WildMenu = { link = "PmenuSel" },

        Comment = { fg = c.outline, italic = true },
        Constant = { fg = orange },
        String = { fg = green },
        Character = { fg = green },
        Number = { fg = orange },
        Boolean = { fg = orange, bold = true },
        Float = { link = "Number" },
        Identifier = { fg = c.on_background },
        Function = { fg = c.primary },
        Statement = { fg = c.tertiary },
        Conditional = { fg = c.tertiary },
        Repeat = { fg = c.tertiary },
        Label = { fg = c.tertiary },
        Operator = { fg = blend(c.secondary, c.on_background, 0.6) },
        Keyword = { fg = c.tertiary },
        Exception = { fg = c.tertiary },
        PreProc = { fg = violet },
        Include = { fg = violet },
        Define = { fg = violet },
        Macro = { fg = violet },
        PreCondit = { fg = violet },
        Type = { fg = c.secondary },
        StorageClass = { fg = c.secondary },
        Structure = { fg = c.secondary },
        Typedef = { fg = c.secondary },
        Special = { fg = accent },
        SpecialChar = { fg = accent },
        Tag = { fg = c.primary },
        Delimiter = { fg = c.on_surface_variant },
        SpecialComment = { fg = c.outline, bold = true },
        Debug = { fg = c.error },
        Underlined = { underline = true },
        Ignore = { fg = c.outline_variant },
        Error = { fg = c.error },
        Todo = { fg = c.on_primary, bg = c.primary, bold = true },
        Added = { fg = green },
        Changed = { fg = c.primary },
        Removed = { fg = c.error },

        -- Treesitter ---------------------------------------------------------------
        ["@variable"] = { fg = c.on_background },
        ["@variable.builtin"] = { fg = c.error, italic = true },
        ["@variable.parameter"] = { fg = param, italic = true },
        ["@variable.member"] = { fg = prop },
        ["@property"] = { fg = prop },
        ["@constant"] = { fg = orange },
        ["@constant.builtin"] = { fg = orange, italic = true },
        ["@constant.macro"] = { fg = violet },
        ["@module"] = { fg = blend(c.secondary, c.on_background, 0.7) },
        ["@label"] = { fg = c.tertiary },
        ["@string"] = { fg = green },
        ["@string.documentation"] = { fg = blend(green, c.outline, 0.6), italic = true },
        ["@string.regexp"] = { fg = accent },
        ["@string.escape"] = { fg = accent, bold = true },
        ["@string.special"] = { fg = accent },
        ["@string.special.url"] = { fg = c.primary, underline = true },
        ["@character.special"] = { fg = accent },
        ["@type"] = { fg = c.secondary },
        ["@type.builtin"] = { fg = c.secondary, italic = true },
        ["@attribute"] = { fg = violet },
        ["@function"] = { fg = c.primary },
        ["@function.builtin"] = { fg = c.primary, italic = true },
        ["@function.macro"] = { fg = violet },
        ["@constructor"] = { fg = c.secondary, bold = true },
        ["@keyword"] = { fg = c.tertiary },
        ["@keyword.function"] = { fg = c.tertiary, italic = true },
        ["@keyword.return"] = { fg = c.tertiary, italic = true },
        ["@keyword.import"] = { fg = violet },
        ["@keyword.directive"] = { fg = violet },
        ["@punctuation"] = { fg = c.on_surface_variant },
        ["@punctuation.bracket"] = { fg = blend(c.on_surface_variant, c.outline, 0.7) },
        ["@punctuation.special"] = { fg = accent },
        ["@comment.documentation"] = { fg = blend(c.outline, c.on_surface_variant, 0.6), italic = true },
        ["@comment.error"] = { fg = c.on_error, bg = c.error, bold = true },
        ["@comment.warning"] = { fg = c.background, bg = yellow, bold = true },
        ["@comment.todo"] = { fg = c.on_primary, bg = c.primary, bold = true },
        ["@comment.note"] = { fg = c.on_secondary, bg = c.secondary, bold = true },
        ["@tag"] = { fg = c.primary },
        ["@tag.attribute"] = { fg = c.secondary, italic = true },
        ["@tag.delimiter"] = { fg = c.on_surface_variant },
        ["@diff.plus"] = { fg = green },
        ["@diff.minus"] = { fg = c.error },
        ["@diff.delta"] = { fg = c.primary },

        -- Markup / markdown
        ["@markup.strong"] = { bold = true },
        ["@markup.italic"] = { italic = true },
        ["@markup.strikethrough"] = { strikethrough = true },
        ["@markup.underline"] = { underline = true },
        ["@markup.heading"] = { fg = c.primary, bold = true },
        ["@markup.heading.1"] = { fg = c.primary, bold = true },
        ["@markup.heading.2"] = { fg = c.secondary, bold = true },
        ["@markup.heading.3"] = { fg = c.tertiary, bold = true },
        ["@markup.heading.4"] = { fg = green, bold = true },
        ["@markup.heading.5"] = { fg = orange, bold = true },
        ["@markup.heading.6"] = { fg = accent, bold = true },
        ["@markup.quote"] = { fg = c.on_surface_variant, italic = true },
        ["@markup.math"] = { fg = accent },
        ["@markup.link"] = { fg = c.tertiary },
        ["@markup.link.label"] = { fg = c.primary },
        ["@markup.link.url"] = { fg = c.primary, underline = true },
        ["@markup.raw"] = { fg = green, bg = bg_dim },
        ["@markup.list"] = { fg = c.tertiary },
        ["@markup.list.checked"] = { fg = green },
        ["@markup.list.unchecked"] = { fg = c.outline },

        -- LSP ------------------------------------------------------------------------
        ["@lsp.type.comment"] = {},
        ["@lsp.type.variable"] = {},
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.interface"] = { fg = blend(c.secondary, c.primary, 0.7) },
        ["@lsp.type.macro"] = { link = "@function.macro" },
        ["@lsp.type.namespace"] = { link = "@module" },
        ["@lsp.type.parameter"] = { link = "@variable.parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.struct"] = { link = "@type" },
        ["@lsp.typemod.variable.readonly"] = { link = "@constant" },
        ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
        ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
        LspReferenceText = { bg = c.surface_container_high },
        LspReferenceRead = { bg = c.surface_container_high },
        LspReferenceWrite = { bg = c.surface_container_high, underline = true },
        LspSignatureActiveParameter = { fg = c.tertiary, bold = true, underline = true },
        LspCodeLens = { fg = c.outline, italic = true },
        LspInlayHint = { fg = blend(c.outline, c.background, 0.8), bg = tint(c.primary), italic = true },

        -- Diagnostics ------------------------------------------------------------------
        DiagnosticError = { fg = c.error },
        DiagnosticWarn = { fg = yellow },
        DiagnosticInfo = { fg = c.primary },
        DiagnosticHint = { fg = c.secondary },
        DiagnosticOk = { fg = green },
        DiagnosticVirtualTextError = { fg = c.error, bg = tint(c.error) },
        DiagnosticVirtualTextWarn = { fg = yellow, bg = tint(yellow) },
        DiagnosticVirtualTextInfo = { fg = c.primary, bg = tint(c.primary) },
        DiagnosticVirtualTextHint = { fg = c.secondary, bg = tint(c.secondary) },
        DiagnosticVirtualTextOk = { fg = green, bg = tint(green) },
        DiagnosticUnderlineError = { undercurl = true, sp = c.error },
        DiagnosticUnderlineWarn = { undercurl = true, sp = yellow },
        DiagnosticUnderlineInfo = { undercurl = true, sp = c.primary },
        DiagnosticUnderlineHint = { undercurl = true, sp = c.secondary },
        DiagnosticUnderlineOk = { undercurl = true, sp = green },
        DiagnosticUnnecessary = { fg = c.outline, italic = true },
        DiagnosticDeprecated = { strikethrough = true, sp = c.outline },
        DiagnosticSignError = { fg = c.error, bg = bg },
        DiagnosticSignWarn = { fg = yellow, bg = bg },
        DiagnosticSignInfo = { fg = c.primary, bg = bg },
        DiagnosticSignHint = { fg = c.secondary, bg = bg },

        -- Diff / git -----------------------------------------------------------------------
        DiffAdd = { bg = diff_add },
        DiffChange = { bg = diff_change },
        DiffDelete = { fg = blend(c.error, c.background, 0.5), bg = diff_del },
        DiffText = { bg = diff_text },
        diffAdded = { fg = green },
        diffRemoved = { fg = c.error },
        diffChanged = { fg = c.primary },
        diffFile = { fg = c.tertiary },
        diffLine = { fg = c.outline },
        GitSignsAdd = { fg = green },
        GitSignsChange = { fg = c.primary },
        GitSignsDelete = { fg = c.error },
        GitSignsAddInline = { bg = diff_text },
        GitSignsDeleteInline = { bg = blend(c.error, c.background, 0.3) },
        GitSignsChangeInline = { bg = diff_text },
        GitSignsCurrentLineBlame = { fg = c.outline, italic = true },
        MiniDiffSignAdd = { fg = green },
        MiniDiffSignChange = { fg = c.primary },
        MiniDiffSignDelete = { fg = c.error },

        -- Telescope / pickers ------------------------------------------------------------------
        TelescopeNormal = { link = "NormalFloat" },
        TelescopeBorder = { link = "FloatBorder" },
        TelescopeTitle = { fg = c.on_primary, bg = c.primary, bold = true },
        TelescopePromptNormal = { fg = c.on_surface, bg = c.surface_container_high },
        TelescopePromptBorder = { fg = c.surface_container_high, bg = c.surface_container_high },
        TelescopePromptTitle = { fg = c.on_tertiary, bg = c.tertiary, bold = true },
        TelescopePromptPrefix = { fg = c.primary },
        TelescopePreviewTitle = { fg = c.on_secondary, bg = c.secondary, bold = true },
        TelescopeResultsTitle = { fg = c.on_surface_variant, bg = float },
        TelescopeSelection = { fg = c.on_primary_container, bg = c.primary_container },
        TelescopeSelectionCaret = { fg = c.primary, bg = c.primary_container },
        TelescopeMatching = { fg = c.tertiary, bold = true },
        FzfLuaNormal = { link = "NormalFloat" },
        FzfLuaBorder = { link = "FloatBorder" },
        FzfLuaTitle = { fg = c.primary, bold = true },
        SnacksPickerMatch = { fg = c.tertiary, bold = true },
        SnacksPickerDir = { fg = c.outline },
        SnacksIndent = { fg = indent },
        SnacksIndentScope = { fg = indent_act },
        SnacksDashboardHeader = { fg = c.primary },
        SnacksDashboardKey = { fg = c.tertiary },
        SnacksDashboardIcon = { fg = c.secondary },
        SnacksDashboardDesc = { fg = c.on_surface },
        MiniPickMatchRanges = { fg = c.tertiary, bold = true },

        -- Completion
        BlinkCmpMenu = { link = "Pmenu" },
        BlinkCmpMenuBorder = { link = "FloatBorder" },
        BlinkCmpMenuSelection = { link = "PmenuSel" },
        BlinkCmpScrollBarThumb = { link = "PmenuThumb" },
        BlinkCmpScrollBarGutter = { link = "PmenuSbar" },
        BlinkCmpLabel = { fg = c.on_surface },
        BlinkCmpLabelDeprecated = { fg = c.outline, strikethrough = true },
        BlinkCmpLabelMatch = { fg = c.primary, bold = true },
        BlinkCmpLabelDetail = { fg = c.outline },
        BlinkCmpLabelDescription = { fg = c.outline },
        BlinkCmpGhostText = { fg = c.outline_variant, italic = true },
        BlinkCmpDoc = { link = "NormalFloat" },
        BlinkCmpDocBorder = { link = "FloatBorder" },
        BlinkCmpSignatureHelp = { link = "NormalFloat" },
        BlinkCmpSignatureHelpBorder = { link = "FloatBorder" },
        BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },
        CmpItemAbbr = { fg = c.on_surface },
        CmpItemAbbrDeprecated = { fg = c.outline, strikethrough = true },
        CmpItemAbbrMatch = { fg = c.primary, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = c.primary },
        CmpItemMenu = { fg = c.outline },
        CmpGhostText = { fg = c.outline_variant, italic = true },

        -- File explorers -----------------------------------------------------------------------------
        NvimTreeNormal = { fg = c.on_surface, bg = side },
        NvimTreeFolderName = { fg = c.primary },
        NvimTreeOpenedFolderName = { fg = c.primary, bold = true },
        NvimTreeRootFolder = { fg = c.tertiary, bold = true },
        NvimTreeIndentMarker = { fg = indent },
        NvimTreeGitDirty = { fg = c.primary },
        NvimTreeGitNew = { fg = green },
        NvimTreeGitDeleted = { fg = c.error },
        NeoTreeNormal = { fg = c.on_surface, bg = side },
        NeoTreeNormalNC = { link = "NeoTreeNormal" },
        NeoTreeDirectoryName = { fg = c.primary },
        NeoTreeDirectoryIcon = { fg = c.primary },
        NeoTreeRootName = { fg = c.tertiary, bold = true },
        NeoTreeIndentMarker = { fg = indent },
        NeoTreeGitAdded = { fg = green },
        NeoTreeGitModified = { fg = c.primary },
        NeoTreeGitDeleted = { fg = c.error },
        NeoTreeGitUntracked = { fg = c.tertiary },
        OilDir = { fg = c.primary, bold = true },
        OilFile = { fg = c.on_surface },
        OilLink = { fg = c.secondary },
        MiniFilesNormal = { link = "NormalFloat" },
        MiniFilesBorder = { link = "FloatBorder" },
        MiniFilesTitleFocused = { fg = c.primary, bg = float, bold = true },
        MiniFilesDirectory = { fg = c.primary },

        -- Indent guides / rainbow ------------------------------------------------------------------------
        IblIndent = { fg = indent },
        IblScope = { fg = indent_act },
        IblWhitespace = { fg = indent },
        MiniIndentscopeSymbol = { fg = indent_act },
        RainbowDelimiterRed = { fg = c.error },
        RainbowDelimiterYellow = { fg = yellow },
        RainbowDelimiterBlue = { fg = c.primary },
        RainbowDelimiterOrange = { fg = orange },
        RainbowDelimiterGreen = { fg = green },
        RainbowDelimiterViolet = { fg = c.tertiary },
        RainbowDelimiterCyan = { fg = c.secondary },

        -- which-key / lazy / mason ---------------------------------------------------------------------------
        WhichKey = { fg = c.primary },
        WhichKeyGroup = { fg = c.tertiary },
        WhichKeyDesc = { fg = c.on_surface },
        WhichKeySeparator = { fg = c.outline },
        WhichKeyNormal = { link = "NormalFloat" },
        WhichKeyBorder = { link = "FloatBorder" },
        WhichKeyValue = { fg = c.outline },
        LazyH1 = { fg = c.on_primary, bg = c.primary, bold = true },
        LazyButton = { fg = c.on_surface, bg = c.surface_container_high },
        LazyButtonActive = { fg = c.on_primary_container, bg = c.primary_container, bold = true },
        LazySpecial = { fg = c.tertiary },
        LazyProgressDone = { fg = c.primary },
        LazyProgressTodo = { fg = c.outline_variant },
        MasonHeader = { fg = c.on_primary, bg = c.primary, bold = true },
        MasonHighlight = { fg = c.primary },
        MasonHighlightBlock = { fg = c.on_primary, bg = c.primary },
        MasonMutedBlock = { fg = c.on_surface_variant, bg = c.surface_container_high },

        -- Motion: flash / leap / mini.jump -----------------------------------------------------------------------
        FlashLabel = { fg = c.on_tertiary, bg = c.tertiary, bold = true },
        FlashMatch = { fg = c.on_secondary, bg = c.secondary },
        FlashCurrent = { fg = c.on_primary, bg = c.primary },
        FlashBackdrop = { fg = c.outline },
        LeapLabelPrimary = { fg = c.on_tertiary, bg = c.tertiary, bold = true },
        LeapBackdrop = { fg = c.outline },
        MiniJump = { fg = c.on_tertiary, bg = c.tertiary },

        -- noice / notify ---------------------------------------------------------------------------------------------
        NoiceCmdlinePopup = { fg = c.on_surface, bg = float },
        NoiceCmdlinePopupBorder = { fg = c.primary, bg = float },
        NoiceCmdlineIcon = { fg = c.primary },
        NoiceConfirmBorder = { fg = c.tertiary, bg = float },
        NotifyERRORBorder = { fg = blend(c.error, c.background, 0.5) },
        NotifyWARNBorder = { fg = blend(yellow, c.background, 0.5) },
        NotifyINFOBorder = { fg = blend(c.primary, c.background, 0.5) },
        NotifyDEBUGBorder = { fg = c.outline_variant },
        NotifyTRACEBorder = { fg = blend(c.tertiary, c.background, 0.5) },
        NotifyERRORIcon = { fg = c.error },
        NotifyWARNIcon = { fg = yellow },
        NotifyINFOIcon = { fg = c.primary },
        NotifyDEBUGIcon = { fg = c.outline },
        NotifyTRACEIcon = { fg = c.tertiary },
        NotifyERRORTitle = { fg = c.error },
        NotifyWARNTitle = { fg = yellow },
        NotifyINFOTitle = { fg = c.primary },
        NotifyDEBUGTitle = { fg = c.outline },
        NotifyTRACETitle = { fg = c.tertiary },

        -- trouble / todo-comments / illuminate -------------------------------------------------------------------------
        TroubleNormal = { fg = c.on_surface, bg = side },
        TroubleCount = { fg = c.on_tertiary, bg = c.tertiary },
        TodoBgTODO = { fg = c.on_primary, bg = c.primary, bold = true },
        TodoBgFIX = { fg = c.on_error, bg = c.error, bold = true },
        TodoBgHACK = { fg = c.background, bg = orange, bold = true },
        TodoBgWARN = { fg = c.background, bg = yellow, bold = true },
        TodoBgNOTE = { fg = c.on_secondary, bg = c.secondary, bold = true },
        TodoBgPERF = { fg = c.on_tertiary, bg = c.tertiary, bold = true },
        TodoFgTODO = { fg = c.primary },
        TodoFgFIX = { fg = c.error },
        TodoFgHACK = { fg = orange },
        TodoFgWARN = { fg = yellow },
        TodoFgNOTE = { fg = c.secondary },
        TodoFgPERF = { fg = c.tertiary },
        IlluminatedWordText = { bg = c.surface_container_high },
        IlluminatedWordRead = { bg = c.surface_container_high },
        IlluminatedWordWrite = { bg = c.surface_container_high, underline = true },

        -- render-markdown ------------------------------------------------------------------------------------------------
        RenderMarkdownH1Bg = { bg = tint(c.primary, 0.15) },
        RenderMarkdownH2Bg = { bg = tint(c.secondary, 0.15) },
        RenderMarkdownH3Bg = { bg = tint(c.tertiary, 0.15) },
        RenderMarkdownH4Bg = { bg = tint(green, 0.15) },
        RenderMarkdownH5Bg = { bg = tint(orange, 0.15) },
        RenderMarkdownH6Bg = { bg = tint(accent, 0.15) },
        RenderMarkdownH1 = { link = "@markup.heading.1" },
        RenderMarkdownH2 = { link = "@markup.heading.2" },
        RenderMarkdownH3 = { link = "@markup.heading.3" },
        RenderMarkdownH4 = { link = "@markup.heading.4" },
        RenderMarkdownH5 = { link = "@markup.heading.5" },
        RenderMarkdownH6 = { link = "@markup.heading.6" },
        RenderMarkdownCode = { bg = bg_dim },
        RenderMarkdownCodeInline = { fg = green, bg = bg_dim },
        RenderMarkdownBullet = { fg = c.tertiary },
        RenderMarkdownQuote = { fg = c.outline },
        RenderMarkdownTableHead = { fg = c.primary, bold = true },
        RenderMarkdownTableRow = { fg = c.on_surface_variant },

        -- DAP -------------------------------------------------------------------------------------------------------------
        DapBreakpoint = { fg = c.error },
        DapBreakpointCondition = { fg = yellow },
        DapLogPoint = { fg = c.primary },
        DapStopped = { fg = green, bg = tint(green) },
        DapStoppedLine = { bg = tint(green) },

        -- mini.statusline
        MiniStatuslineModeNormal = { fg = c.on_primary, bg = c.primary, bold = true },
        MiniStatuslineModeInsert = { fg = c.on_secondary, bg = c.secondary, bold = true },
        MiniStatuslineModeVisual = { fg = c.on_tertiary, bg = c.tertiary, bold = true },
        MiniStatuslineModeReplace = { fg = c.on_error, bg = c.error, bold = true },
        MiniStatuslineModeCommand = { fg = c.background, bg = orange, bold = true },
        MiniStatuslineFilename = { fg = c.on_surface, bg = c.surface_container_high },
        MiniStatuslineFileinfo = { fg = c.on_surface_variant, bg = c.surface_container },
        MiniStatuslineDevinfo = { fg = c.on_surface_variant, bg = c.surface_container },
        MiniCursorword = { bg = c.surface_container_high },
        MiniTrailspace = { bg = c.error },
    }

    -- Completion
    local kinds = {
        Text = c.on_surface_variant,
        Method = c.primary,
        Function = c.primary,
        Constructor = c.secondary,
        Field = prop,
        Variable = c.on_background,
        Property = prop,
        Class = c.secondary,
        Interface = c.secondary,
        Struct = c.secondary,
        Module = violet,
        Keyword = c.tertiary,
        Snippet = green,
        Color = orange,
        File = c.primary,
        Folder = c.primary,
        Enum = c.secondary,
        EnumMember = orange,
        Constant = orange,
        Operator = c.on_surface_variant,
        TypeParameter = c.secondary,
        Unit = orange,
        Value = orange,
        Reference = c.tertiary,
        Event = yellow,
    }
    for kind, color in pairs(kinds) do
        g["BlinkCmpKind" .. kind] = { fg = color }
        g["CmpItemKind" .. kind] = { fg = color }
    end

    -- Terminal ANSI colors ---------------------------------------------------------------------------------------------------
    local function bright(hex)
        return blend(hex, c.on_background, 0.78)
    end
    local base = {
        c.surface_container_high,
        c.error,
        green,
        yellow,
        c.primary,
        c.tertiary,
        c.secondary,
        c.on_surface_variant,
    }
    local term = {}
    for i, color in ipairs(base) do
        term[i] = color
        term[i + 8] = (i == 1 and c.outline) or (i == 8 and c.on_surface) or bright(color)
    end

    return g, term
end

return M
