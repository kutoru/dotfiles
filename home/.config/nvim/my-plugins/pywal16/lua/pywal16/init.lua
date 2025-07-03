local set_highlights = function(color_cache_path)
  local colors = require("pywal16.colors").get_colors(color_cache_path)
  local highlights = require("pywal16.highlights").get_highlights(colors)

  for name, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, name, opts)
  end
end

local setup = function(opts)
  opts = opts or {}

  local color_cache_path = opts.color_cache_path or os.getenv("HOME") .. "/.cache/wal/colors"

  -- load and set the colors
  set_highlights(color_cache_path)

  -- start the watcher
  require("pywal16.watcher").watch(color_cache_path, function()
    set_highlights(color_cache_path)
  end)
end

return {
  setup = setup,
}
