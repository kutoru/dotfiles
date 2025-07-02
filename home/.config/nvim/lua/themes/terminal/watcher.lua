local watcher

local setup = function(filepath, on_change)
  if watcher then
    watcher:stop()
    watcher:close()
  end

  watcher = vim.uv.new_fs_event()
  -- TODO: this runs two times at once, implement a delay or something
  watcher:start(filepath, {}, vim.schedule_wrap(on_change))
end

return {
  setup = setup,
}
