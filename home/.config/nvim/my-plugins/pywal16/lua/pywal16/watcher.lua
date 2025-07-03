local watcher
local run_after = 0

local watch = function(filepath, on_change)
  if watcher then
    watcher:stop()
    watcher:close()
  end

  watcher = vim.uv.new_fs_event()

  watcher:start(
    filepath,
    {},
    vim.schedule_wrap(function(err)
      -- debounce
      local now = os.time()
      if now <= run_after then
        return
      end
      run_after = now + 5

      -- the actual callback
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
