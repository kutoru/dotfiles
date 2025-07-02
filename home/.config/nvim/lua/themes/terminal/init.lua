-- load colors from pywal cache
local get_colors = function(color_cache_path)
  local handle = io.popen("cat " .. color_cache_path .. [[ | grep 'color' | sed 's/.*"\(.*\)"/\1/']])

  if not handle then
    return nil
  end

  local vim_colors = handle:read("*a")
  handle:close()

  local colors = {}
  for str in string.gmatch(vim_colors, "([^%s]+)") do
    table.insert(colors, str)
  end

  return colors
end

-- set highlights
local hi = function(names, opts)
  if type(names) == "table" then
    for _, name in ipairs(names) do
      vim.api.nvim_set_hl(0, name, opts)
    end
  else
    vim.api.nvim_set_hl(0, names, opts)
  end
end

-- override the following colors:
-- NvimLightCyan
-- NvimDarkCyan
-- NvimLightGreen
-- NvimLightBlue
local set_colors = function(color_cache_path)
  local colors = get_colors(color_cache_path)
  if not colors then
    vim.notify("Could not load pywal colors", vim.log.levels.ERROR)
    return
  end

  local LC = colors[10]
  local DC = colors[2]
  local LG = colors[11]
  local LB = colors[12]

  hi({
    "LineNr",
    "Directory",
    "MoreMsg",
    "Question",
    "QuickFixLine",
    "Special",
    "DiagnosticInfo",
    "Function",
    "Changed",
    "CmpItemKindDefault",
  }, { fg = LC })
  hi("SpellRare", { undercurl = true, sp = LC })
  hi("DiagnosticUnderlineInfo", { underline = true, sp = LC })

  hi({ "LineNrAbove", "LineNrBelow" }, { fg = DC })
  hi("DiffText", { fg = "NvimLightGrey1", bg = DC })

  hi({ "ModeMsg", "DiagnosticOk", "String", "Added" }, { fg = LG })
  hi("SpellLocal", { undercurl = true, sp = LG })
  hi("DiagnosticUnderlineOk", { underline = true, sp = LG })

  hi({ "DiagnosticHint", "Identifier" }, { fg = LB })
  hi("DiagnosticUnderlineHint", { underline = true, sp = LB })
end

local setup = function(color_cache_path)
  if not color_cache_path then
    color_cache_path = os.getenv("HOME") .. "/.cache/wal/colors-wal.vim"
  end

  -- adjust the default theme
  require("themes.initial")
  set_colors(color_cache_path)

  -- start the watcher
  require("themes.terminal.watcher").setup(color_cache_path, function(err)
    if err then
      vim.notify("Error when watching pywal file: " .. err, vim.log.levels.ERROR)
    else
      set_colors(color_cache_path)
    end
  end)
end

return {
  setup = setup,
}
