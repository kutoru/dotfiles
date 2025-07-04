local common = {
  RGB = true,
  RRGGBB = true,
  RRGGBBAA = true,
  names = true,

  rgb_fn = false,
  hsl_fn = false,
  css = false,
  css_fn = false,
}

local css = {
  RGB = true,
  RRGGBB = true,
  RRGGBBAA = true,
  names = true,

  rgb_fn = true,
  hsl_fn = true,
  css = true,
  css_fn = true,
}

return {
  "norcalli/nvim-colorizer.lua",
  opts = {
    ["*"] = common,
    css = css,
    scss = css,
  },
}
