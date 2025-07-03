local watcher

local watch = function(filepath, on_change)
  if watcher then
    watcher:stop()
    watcher:close()
  end

  watcher = vim.uv.new_fs_event()

  -- TODO: this runs two times at once, implement a delay or something
  watcher:start(
    filepath,
    {},
    vim.schedule_wrap(function(err)
      if err then
        vim.notify("Error watching pywal cache: " .. err, vim.log.levels.ERROR)
      else
        on_change()
      end
    end)
  )
end

return {
  watch = watch,
}
