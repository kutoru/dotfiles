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
-- Question
-- netrwPlain

-- lines:
-- LineNr
-- LineNrAbove
-- LineNrBelow

-- Dark:  1  2  3  4  5  6  7  8
-- Light: 9  10 11 12 13 14 15 16

local get_highlights = function(colors)
  local ident = colors[10]
  local identDark = colors[2]

  local string = colors[11]
  local type = colors[12]
  local constant = colors[15]

  return {
    -- code
    Function = { fg = ident },
    Identifier = { fg = ident },

    Type = { fg = type },
    Special = { fg = type },

    String = { fg = string },

    Statement = { fg = constant, bold = true },
    Constant = { fg = constant },

    -- other
    LineNr = { fg = ident },
    LineNrAbove = { fg = identDark },
    LineNrBelow = { fg = identDark },

    Directory = { fg = ident },
    Question = { fg = ident },
    netrwPlain = { fg = constant },
  }
end

local get_highlights_but_more_colors = function(colors)
  local main = colors[10]
  local mainDark = colors[2]

  local string = colors[11]
  local ident = colors[12]
  local type = colors[13]
  local statement = colors[14]
  local constant = colors[15]

  return {
    LineNr = { fg = main },
    LineNrAbove = { fg = mainDark },
    LineNrBelow = { fg = mainDark },

    Directory = { fg = main },
    Question = { fg = main },
    Function = { fg = main },

    String = { fg = string },
    Identifier = { fg = ident },
    Type = { fg = type },
    Special = { fg = type },
    Statement = { fg = statement },
    Constant = { fg = constant },
  }
end

return {
  get_highlights = get_highlights,
}
