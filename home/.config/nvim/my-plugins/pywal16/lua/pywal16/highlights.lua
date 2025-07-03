local get_highlights = function(colors)
  local ident = colors[10]
  local identDark = colors[2]
  local string = colors[11]
  local type = colors[12]
  local constant = colors[15]

  return {
    -- code
    Identifier = { fg = ident },
    Function = { fg = ident },
    String = { fg = string },
    Type = { fg = type },
    Special = { fg = type },
    Constant = { fg = constant },
    Statement = { fg = constant, bold = true },

    -- lines
    LineNr = { fg = ident },
    LineNrAbove = { fg = identDark },
    LineNrBelow = { fg = identDark },

    -- netrw
    Directory = { fg = ident },
    Question = { fg = ident },
    netrwPlain = { fg = constant },

    -- tsx
    ["@tag.attribute.tsx"] = { fg = ident },
  }
end

return {
  get_highlights = get_highlights,
}
