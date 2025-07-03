-- code:
-- @variable
-- Statement
-- Type
-- Constant
-- Special
-- Function
-- String
-- Identifier

-- netrw:
-- Directory
-- something for files?

-- lines:
-- LineNr
-- LineNrAbove
-- LineNrBelow

local get_highlights = function(colors)
  local LC = colors[10]
  local DC = colors[2]
  local LG = colors[11]
  local LB = colors[12]

  return {
    LineNr = { fg = LC },
    Directory = { fg = LC },
    MoreMsg = { fg = LC },
    Question = { fg = LC },
    QuickFixLine = { fg = LC },
    Special = { fg = LC },
    DiagnosticInfo = { fg = LC },
    Function = { fg = LC },
    Changed = { fg = LC },
    CmpItemKindDefault = { fg = LC },
    SpellRare = { undercurl = true, sp = LC },
    DiagnosticUnderlineInfo = { underline = true, sp = LC },

    LineNrAbove = { fg = DC },
    LineNrBelow = { fg = DC },
    DiffText = { fg = "NvimLightGrey1", bg = DC },

    ModeMsg = { fg = LG },
    DiagnosticOk = { fg = LG },
    String = { fg = LG },
    Added = { fg = LG },
    SpellLocal = { undercurl = true, sp = LG },
    DiagnosticUnderlineOk = { underline = true, sp = LG },

    DiagnosticHint = { fg = LB },
    Identifier = { fg = LB },
    DiagnosticUnderlineHint = { underline = true, sp = LB },
  }
end

return {
  get_highlights = get_highlights,
}
