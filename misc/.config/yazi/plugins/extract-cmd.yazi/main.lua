local M = {}

function M:entry()
  local tab = cx.active
  local hovered = tab.current.hovered
  
  if not hovered then
    ya.notify({
      title = "No file selected",
      content = "Please select an archive to extract",
      timeout = 5,
      level = "error",
    })
    return
  end

  local file_path = tostring(hovered.url)
  
  -- Run ouch decompress command
  local cmd = Command("ouch"):arg("d"):arg("-y"):arg(file_path)
      :stderr(Command.PIPED)
      :output()
  
  if not cmd.status.success then
    ya.notify({
      title = "Extraction failed",
      content = cmd.stderr,
      timeout = 5,
      level = "error",
    })
  else
    ya.notify({
      title = "Extraction complete",
      content = "Archive extracted successfully",
      timeout = 3,
      level = "info",
    })
    -- Refresh the file list
    ya.emit("refresh", {})
  end
end

return M
