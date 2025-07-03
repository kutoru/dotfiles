local get_colors = function(color_cache_path)
  local colors = {}

  for color in io.lines(color_cache_path) do
    table.insert(colors, color)
  end

  return colors
end

return {
  get_colors = get_colors,
}
