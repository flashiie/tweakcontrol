function getScaleValue ()
  local screenW,screenH = guiGetScreenSize()
  local devScreenX, devScreenY = 1920,1080

  local scaleValue = screenH / devScreenY

  return math.max(scaleValue, 1), screenW, screenH
end