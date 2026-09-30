local M = {}

local c = {
  bg         = "#080808",
  fg         = "#C0C0C0",
  bg_dim     = "#101010",
  bg_modal   = "#0C0C0C",
  border     = "#2A2A2A",
  gray       = "#555555",
  gray_hi    = "#888888",
  white      = "#E0E0E0",
  keyword    = "#C792EA",
  typ        = "#FFCB6B",
  builtin    = "#F07178",
  func       = "#82AAFF",
  string     = "#C3E88D",
  number     = "#F78C6C",
  constant   = "#C792EA",
  operator   = "#89DDFF",
  comment    = "#546E7A",
  macro      = "#C792EA",
  attribute  = "#FFCB6B",
  variable   = "#EEFFFF",
  parameter  = "#EEFFFF",
  field      = "#82AAFF",
  punctuation= "#A0A0A0",
  method     = "#82AAFF",
  property   = "#82AAFF",
  decorator  = "#FFCB6B",
  include    = "#C792EA",
  preproc    = "#C792EA",
  define     = "#C792EA",
  conditional= "#C792EA",
  repeat_k    = "#C792EA",
  label      = "#C792EA",
  exception  = "#C792EA",
  boolean    = "#F78C6C",
  float      = "#F78C6C",
  constructor= "#82AAFF",
  type_builtin = "#FFCB6B",
  namespace  = "#EEFFFF",
  include_file = "#C3E88D",
  ref         = "#82AAFF",
  text        = "#C0C0C0",
}

local function hl(name, spec)
  local def = { fg = spec.fg, bg = spec.bg, bold = spec.bold, italic = spec.italic, underline = spec.underline, reverse = spec.reverse }
  for k, v in pairs(def) do
    if v == nil then def[k] = nil end
  end
  vim.api.nvim_set_hl(0, name, def)
end

function M.setup()
  hl("Normal",          { fg = c.fg,      bg = c.bg })
  hl("NormalNC",        { fg = c.fg,      bg = c.bg })
  hl("NormalFloat",     { fg = c.fg,      bg = c.bg_modal })
  hl("FloatBorder",     { fg = c.border,  bg = c.bg_modal })
  hl("FloatTitle",      { fg = c.gray_hi, bg = c.bg_modal })
  hl("SignColumn",      { fg = c.gray,    bg = c.bg })
  hl("LineNr",          { fg = c.gray,    bg = c.bg })
  hl("CursorLineNr",    { fg = c.fg,      bg = c.bg, bold = true })
  hl("CursorLine",      { fg = nil,       bg = c.bg_dim })
  hl("CursorColumn",    { fg = nil,       bg = c.bg_dim })
  hl("Visual",          { fg = nil,       bg = "#1A1A1A" })
  hl("VisualNOS",       { fg = nil,       bg = "#1A1A1A" })
  hl("Search",          { fg = c.fg,      bg = "#1E2A3A", reverse = true })
  hl("IncSearch",       { fg = c.bg,      bg = c.fg })
  hl("Substitute",      { fg = c.bg,      bg = c.fg })
  hl("Pmenu",           { fg = c.fg,      bg = c.bg_modal })
  hl("PmenuSel",        { fg = c.fg,      bg = "#1E1E1E", bold = true })
  hl("PmenuThumb",      { fg = c.border,  bg = c.border })
  hl("PmenuKind",       { fg = c.gray_hi, bg = c.bg_modal })
  hl("PmenuKindSel",    { fg = c.fg,      bg = c.bg_modal })
  hl("PmenuExtra",      { fg = c.gray,    bg = c.bg_modal })
  hl("PmenuExtraSel",   { fg = c.fg,      bg = c.bg_modal })
  hl("StatusLine",      { fg = c.fg,      bg = c.bg, bold = true })
  hl("StatusLineNC",    { fg = c.gray,    bg = c.bg })
  hl("WinSeparator",    { fg = c.border,  bg = c.bg })
  hl("Folded",          { fg = c.gray,    bg = c.bg_dim })
  hl("FoldColumn",      { fg = c.gray,    bg = c.bg })
  hl("MatchParen",      { fg = c.fg,      bg = nil, bold = true, underline = true })
  hl("NonText",         { fg = c.border,  bg = c.bg })
  hl("EndOfBuffer",     { fg = c.border,  bg = c.bg })
  hl("VertSplit",       { fg = c.border,  bg = c.bg })
  hl("ColorColumn",     { fg = nil,       bg = c.bg_dim })
  hl("Cursor",          { fg = c.bg,      bg = c.fg })
  hl("lCursor",         { fg = c.bg,      bg = c.fg })
  hl("LineHighlight",   { fg = nil,       bg = c.bg_dim })
  hl("Conceal",        { fg = c.gray,    bg = c.bg })
  hl("Whitespace",      { fg = c.border,  bg = c.bg })
  hl("SpellBad",        { fg = c.builtin, bg = nil, underline = true, sp = c.builtin })
  hl("SpellCap",        { fg = c.keyword, bg = nil, underline = true, sp = c.keyword })
  hl("SpellLocal",      { fg = c.string,  bg = nil, underline = true, sp = c.string })
  hl("SpellRare",       { fg = c.attribute, bg = nil, underline = true, sp = c.attribute })

  hl("Comment",         { fg = c.comment, bg = nil, italic = true })
  hl("Todo",            { fg = c.keyword, bg = nil, bold = true })
  hl("Constant",        { fg = c.constant, bg = nil })
  hl("String",          { fg = c.string,  bg = nil })
  hl("Character",       { fg = c.string,  bg = nil })
  hl("Number",          { fg = c.number,  bg = nil })
  hl("Boolean",         { fg = c.boolean, bg = nil })
  hl("Float",           { fg = c.float,   bg = nil })
  hl("Identifier",      { fg = c.variable, bg = nil })
  hl("Function",        { fg = c.func, bg = nil })
  hl("Keyword",         { fg = c.keyword, bg = nil })
  hl("Conditional",     { fg = c.conditional, bg = nil })
  hl("Repeat",          { fg = c.repeat_k,  bg = nil })
  hl("Label",           { fg = c.label,   bg = nil })
  hl("Operator",        { fg = c.operator, bg = nil })
  hl("Exception",       { fg = c.exception, bg = nil })
  hl("Statement",       { fg = c.keyword, bg = nil })
  hl("PreProc",         { fg = c.preproc, bg = nil })
  hl("Include",         { fg = c.include, bg = nil })
  hl("Define",          { fg = c.define,  bg = nil })
  hl("Macro",           { fg = c.macro,   bg = nil })
  hl("PreCondit",       { fg = c.preproc, bg = nil })
  hl("Type",            { fg = c.typ,     bg = nil })
  hl("Structure",       { fg = c.typ,     bg = nil })
  hl("Typedef",         { fg = c.typ,     bg = nil })
  hl("StorageClass",    { fg = c.builtin, bg = nil })
  hl("Tag",             { fg = c.builtin, bg = nil })
  hl("Special",         { fg = c.builtin, bg = nil })
  hl("SpecialChar",     { fg = c.builtin, bg = nil })
  hl("SpecialComment",  { fg = c.comment, bg = nil, italic = true })
  hl("Delimiter",       { fg = c.punctuation, bg = nil })
  hl("Ignore",          { fg = c.gray,    bg = nil })
  hl("Underlined",      { fg = c.fg,      bg = nil, underline = true })
  hl("Bold",            { fg = nil,       bg = nil, bold = true })
  hl("Italic",          { fg = nil,       bg = nil, italic = true })
  hl("Title",           { fg = c.fg,      bg = nil, bold = true })
  hl("Debug",           { fg = c.builtin, bg = nil })
  hl("DiagnosticError", { fg = c.builtin, bg = nil })
  hl("DiagnosticWarn",  { fg = c.typ,     bg = nil })
  hl("DiagnosticInfo",  { fg = c.func, bg = nil })
  hl("DiagnosticHint",  { fg = c.string,  bg = nil })
  hl("DiagnosticVirtualTextError",   { fg = c.builtin, bg = nil })
  hl("DiagnosticVirtualTextWarn",    { fg = c.typ,     bg = nil })
  hl("DiagnosticVirtualTextInfo",    { fg = c.func, bg = nil })
  hl("DiagnosticVirtualTextHint",    { fg = c.string,  bg = nil })
  hl("DiagnosticUnderlineError",     { fg = nil, bg = nil, underline = true, sp = c.builtin })
  hl("DiagnosticUnderlineWarn",      { fg = nil, bg = nil, underline = true, sp = c.typ })
  hl("DiagnosticUnderlineInfo",      { fg = nil, bg = nil, underline = true, sp = c.func })
  hl("DiagnosticUnderlineHint",      { fg = nil, bg = nil, underline = true, sp = c.string })
  hl("LspReferenceText",      { fg = nil, bg = "#1A1A1A" })
  hl("LspReferenceRead",      { fg = nil, bg = "#1A1A1A" })
  hl("LspReferenceWrite",     { fg = nil, bg = "#1A1A1A" })
  hl("LspCodeLens",           { fg = c.gray, bg = nil })
  hl("LspCodeLensSeparator",  { fg = c.border, bg = nil })
  hl("SignatureHelpParameter", { fg = c.fg, bg = "#141414" })
  hl("SignatureHelpContext",   { fg = c.gray_hi, bg = "#141414" })
  hl("InlineVirtualText",      { fg = c.gray, bg = nil })
  hl("NvimTreeNormal",         { fg = c.fg, bg = c.bg })
  hl("NvimTreeEndOfBuffer",    { fg = c.border, bg = c.bg })
  hl("NvimTreeWinSeparator",   { fg = c.bg,  bg = c.bg })
  hl("NvimTreeSignatureField", { fg = c.gray_hi, bg = nil })
  hl("NvimTreeNormalNC",       { fg = c.fg, bg = c.bg })
  hl("NvimTreeCursorLine",     { fg = nil, bg = c.bg_dim })

  -- Git signs
  hl("GitSignsAdd",    { fg = c.string,  bg = nil })
  hl("GitSignsChange", { fg = c.attribute, bg = nil })
  hl("GitSignsDelete", { fg = c.builtin, bg = nil })
  hl("GitSignsAddNr",    { fg = c.string,  bg = nil })
  hl("GitSignsChangeNr", { fg = c.attribute, bg = nil })
  hl("GitSignsDeleteNr", { fg = c.builtin, bg = nil })
  hl("GitSignsAddLn",    { fg = nil, bg = "#142014" })
  hl("GitSignsChangeLn", { fg = nil, bg = "#202014" })
  hl("GitSignsDeleteLn", { fg = nil, bg = "#201414" })

  -- Tree-sitter groups
  hl("@comment",        { fg = c.comment, bg = nil, italic = true })
  hl("@punctuation",    { fg = c.punctuation, bg = nil })
  hl("@punctuation.delimiter", { fg = c.punctuation, bg = nil })
  hl("@punctuation.bracket",   { fg = c.punctuation, bg = nil })
  hl("@punctuation.special",   { fg = c.punctuation, bg = nil })
  hl("@keyword",        { fg = c.keyword, bg = nil })
  hl("@keyword.function", { fg = c.keyword, bg = nil })
  hl("@keyword.operator", { fg = c.operator, bg = nil })
  hl("@keyword.import",   { fg = c.keyword, bg = nil })
  hl("@keyword.modifier", { fg = c.keyword, bg = nil })
  hl("@keyword.repeat",   { fg = c.repeat_k, bg = nil })
  hl("@keyword.conditional", { fg = c.conditional, bg = nil })
  hl("@keyword.exception", { fg = c.exception, bg = nil })
  hl("@keyword.return",   { fg = c.keyword, bg = nil })
  hl("@keyword.debug",    { fg = c.builtin, bg = nil })
  hl("@keyword.function.macro", { fg = c.macro, bg = nil })
  hl("@function",       { fg = c.func, bg = nil })
  hl("@function.builtin", { fg = c.builtin, bg = nil })
  hl("@function.macro",  { fg = c.macro, bg = nil })
  hl("@function.call",   { fg = c.func, bg = nil })
  hl("@function.method", { fg = c.method, bg = nil })
  hl("@function.method.call", { fg = c.method, bg = nil })
  hl("@function.closure", { fg = c.func, bg = nil })
  hl("@type",           { fg = c.typ,     bg = nil })
  hl("@type.builtin",   { fg = c.type_builtin, bg = nil })
  hl("@type.definition", { fg = c.typ,    bg = nil })
  hl("@type.qualifier", { fg = c.builtin, bg = nil })
  hl("@type.parameter", { fg = c.parameter, bg = nil })
  hl("@variable",       { fg = c.variable, bg = nil })
  hl("@variable.builtin", { fg = c.builtin, bg = nil })
  hl("@variable.parameter", { fg = c.parameter, bg = nil })
  hl("@variable.member", { fg = c.variable, bg = nil })
  hl("@property",       { fg = c.property, bg = nil })
  hl("@field",          { fg = c.field,   bg = nil })
  hl("@constant",       { fg = c.constant, bg = nil })
  hl("@constant.builtin", { fg = c.builtin, bg = nil })
  hl("@constant.macro", { fg = c.macro,   bg = nil })
  hl("@string",         { fg = c.string,  bg = nil })
  hl("@string.regexp",  { fg = c.macro,   bg = nil })
  hl("@string.escape",  { fg = c.builtin, bg = nil })
  hl("@string.special", { fg = c.attribute, bg = nil })
  hl("@string.documentation", { fg = c.comment, bg = nil, italic = true })
  hl("@string.source",  { fg = c.string,  bg = nil })
  hl("@number",         { fg = c.number,  bg = nil })
  hl("@number.float",   { fg = c.float,   bg = nil })
  hl("@boolean",        { fg = c.boolean, bg = nil })
  hl("@float",          { fg = c.float,   bg = nil })
  hl("@operator",       { fg = c.operator, bg = nil })
  hl("@attribute",      { fg = c.attribute, bg = nil })
  hl("@attribute.builtin", { fg = c.attribute, bg = nil })
  hl("@property",       { fg = c.property, bg = nil })
  hl("@module",         { fg = c.builtin, bg = nil })
  hl("@tag",            { fg = c.keyword, bg = nil })
  hl("@tag.attribute",  { fg = c.attribute, bg = nil })
  hl("@tag.delimiter",  { fg = c.punctuation, bg = nil })
  hl("@markup.heading", { fg = c.keyword, bg = nil, bold = true })
  hl("@markup.bold",    { fg = nil,       bg = nil, bold = true })
  hl("@markup.italic",  { fg = nil,       bg = nil, italic = true })
  hl("@markup.strikethrough", { fg = nil, bg = nil, strikethrough = true })
  hl("@markup.link",    { fg = c.gray_hi, bg = nil, underline = true })
  hl("@markup.link.label", { fg = c.comment, bg = nil })
  hl("@markup.link.url", { fg = c.func, bg = nil, underline = true })
  hl("@markup.list",    { fg = c.keyword, bg = nil })
  hl("@markup.quote",   { fg = c.gray,    bg = nil })
  hl("@markup.raw",     { fg = c.string,  bg = nil })
  hl("@diff.plus",      { fg = c.string,  bg = nil })
  hl("@diff.minus",     { fg = c.builtin, bg = nil })
  hl("@diff.delta",     { fg = c.typ,     bg = nil })
  hl("@error",          { fg = c.builtin, bg = nil })
  hl("@warning",        { fg = c.typ,     bg = nil })
  hl("@info",           { fg = c.func, bg = nil })
  hl("@hint",           { fg = c.string,  bg = nil })

  -- IDE / LSP
  hl("LspFloatPreview",       { fg = nil,       bg = nil })
  hl("LspFloatPreviewNormal", { fg = c.fg,      bg = c.bg_modal })
  hl("LspFloatPreviewBorder", { fg = c.border,  bg = c.bg_modal })
  hl("LspFloatPreviewShadow", { fg = c.border,  bg = nil })
  hl("LspInlayHint",          { fg = c.gray,    bg = nil, italic = true })
  hl("LspInlayHintForeground",{ fg = c.gray_hi, bg = nil })
  hl("LspInlayHintBackground",{ fg = nil,       bg = c.bg_dim })
  hl("CodeAction",            { fg = c.func,    bg = nil, underline = true })
  hl("CodeActionMenu",        { fg = c.gray_hi, bg = nil })
  hl("Rename",                { fg = c.fg,      bg = nil, bold = true })
  hl("SemanticType",          { fg = c.typ,     bg = nil })
  hl("SemanticTypeBuiltin",   { fg = c.type_builtin, bg = nil })
  hl("SemanticVariable",      { fg = c.variable, bg = nil })
  hl("SemanticProperty",      { fg = c.field,   bg = nil })
  hl("SemanticFunction",      { fg = c.func,    bg = nil })
  hl("SemanticClass",         { fg = c.typ,     bg = nil })
  hl("SemanticEnum",          { fg = c.constant, bg = nil })
  hl("SemanticEnumMember",    { fg = c.field,   bg = nil })
  hl("SemanticInterface",     { fg = c.keyword, bg = nil })
  hl("SemanticKeyword",       { fg = c.keyword, bg = nil })
  hl("SemanticDecorator",     { fg = c.decorator, bg = nil })
  hl("SemanticModifier",      { fg = c.keyword, bg = nil })
  hl("SemanticNumber",        { fg = c.number,  bg = nil })
  hl("SemanticString",        { fg = c.string,  bg = nil })
  hl("SemanticBool",          { fg = c.boolean, bg = nil })

  -- Cmp (completion)
  hl("CmpFloat",              { fg = nil,       bg = c.bg_modal })
  hl("CmpBorder",             { fg = c.border,  bg = c.bg_modal })
  hl("CmpDocumentation",      { fg = c.fg,      bg = c.bg_modal })
  hl("CmpDocumentationBorder",{ fg = c.border,  bg = c.bg_modal })
  hl("CmpItemAbbr",           { fg = c.fg,      bg = c.bg_modal })
  hl("CmpItemAbbrMatch",      { fg = c.fg,      bg = c.bg_modal, bold = true })
  hl("CmpItemAbbrDeprecated", { fg = c.gray,    bg = c.bg_modal, strikethrough = true })
  hl("CmpItemKind",           { fg = c.func,    bg = c.bg_modal })
  hl("CmpItemKindFunction",   { fg = c.func,    bg = c.bg_modal })
  hl("CmpItemKindType",       { fg = c.typ,     bg = c.bg_modal })
  hl("CmpItemKindVariable",   { fg = c.variable, bg = c.bg_modal })
  hl("CmpItemKindConstant",   { fg = c.constant, bg = c.bg_modal })
  hl("CmpItemKindClass",      { fg = c.typ,     bg = c.bg_modal })
  hl("CmpItemKindInterface",  { fg = c.keyword, bg = c.bg_modal })
  hl("CmpItemKindModule",     { fg = c.builtin, bg = c.bg_modal })
  hl("CmpItemKindProperty",   { fg = c.field,   bg = c.bg_modal })
  hl("CmpItemKindEnum",       { fg = c.constant, bg = c.bg_modal })
  hl("CmpItemKindEnumMember", { fg = c.field,   bg = c.bg_modal })
  hl("CmpItemKindEvent",      { fg = c.boolean, bg = c.bg_modal })
  hl("CmpItemKindOperator",   { fg = c.operator, bg = c.bg_modal })
  hl("CmpItemKindFile",       { fg = c.include, bg = c.bg_modal })
  hl("CmpItemKindMethod",     { fg = c.method,  bg = c.bg_modal })
  hl("CmpItemKindField",      { fg = c.field,   bg = c.bg_modal })
  hl("CmpItemKindUnit",       { fg = c.builtin, bg = c.bg_modal })
  hl("CmpItemKindValue",      { fg = c.number,  bg = c.bg_modal })
  hl("CmpItemKindColor",      { fg = c.builtin, bg = c.bg_modal })
  hl("CmpItemKindFolder",     { fg = c.include, bg = c.bg_modal })
  hl("CmpItemKindText",       { fg = c.fg,      bg = c.bg_modal })
  hl("CmpItemKindReference",  { fg = c.ref,     bg = c.bg_modal })
  hl("CmpItemKindKeyword",    { fg = c.keyword, bg = c.bg_modal })
  hl("CmpItemKindSnippet",    { fg = c.macro,   bg = c.bg_modal })
  hl("CmpItemMenu",           { fg = c.gray,    bg = c.bg_modal })

  -- Notify
  hl("NotifyINFOBorder",      { fg = c.func,    bg = c.bg_modal })
  hl("NotifyINFOIcon",        { fg = c.func,    bg = c.bg_modal })
  hl("NotifyINFOTitle",       { fg = c.fg,      bg = c.bg_modal })
  hl("NotifyINFOBody",        { fg = c.fg,      bg = c.bg_modal })
  hl("NotifyWARNBorder",      { fg = c.typ,     bg = c.bg_modal })
  hl("NotifyWARNIcon",        { fg = c.typ,     bg = c.bg_modal })
  hl("NotifyWARNTitle",       { fg = c.fg,      bg = c.bg_modal })
  hl("NotifyWARNCategory",    { fg = c.typ,     bg = c.bg_modal })
  hl("NotifyWARNBody",        { fg = c.fg,      bg = c.bg_modal })
  hl("NotifyERRORBorder",     { fg = c.builtin, bg = c.bg_modal })
  hl("NotifyERRORIcon",       { fg = c.builtin, bg = c.bg_modal })
  hl("NotifyERRORTitle",      { fg = c.fg,      bg = c.bg_modal })
  hl("NotifyERRORBody",       { fg = c.fg,      bg = c.bg_modal })
  hl("NotifyDEBUGBorder",     { fg = c.gray,    bg = c.bg_modal })
  hl("NotifyDEBUGIcon",       { fg = c.gray,    bg = c.bg_modal })
  hl("NotifyDEBUGTitle",      { fg = c.gray,    bg = c.bg_modal })
  hl("NotifyDEBUGBody",       { fg = c.gray,    bg = c.bg_modal })
end

function M.lualine_colors()
  return {
    normal = { a = { fg = c.fg, bg = c.bg }, b = { fg = c.fg, bg = c.bg }, c = { fg = c.gray, bg = c.bg } },
    insert = { a = { fg = c.bg, bg = c.fg, bold = true } },
    visual = { a = { fg = c.bg, bg = c.keyword, bold = true } },
    replace = { a = { fg = c.bg, bg = c.builtin, bold = true } },
    inactive = { a = { fg = c.gray, bg = c.bg }, b = { fg = c.gray, bg = c.bg }, c = { fg = c.gray, bg = c.bg } },
  }
end

return M
