 --[[
    @author Vítor "flashii" Ribeiro
    @copyright (c) MIT
    @license See mode on https://rocketmta.com
--]]

local tweak = TweakControlClass("Flashii Debugger")

local myDebugTable = {
  MyText = "Flashii",
  ToggleLogo = true,
  RotateLogo = 0,
  myColor = "#fff",
  Wave = 0
}

-- Add Input Text of String
tweak:add("input", myDebugTable, 'MyText')


--- Add Boolean Input-Type
tweak:add("input", myDebugTable, 'ToggleLogo')

-- Add Slider Input-Type
tweak:add("input", myDebugTable, 'RotateLogo', {
  step = 1,
  min = 0,
  max = 360
});

-- Add Color Input-type
tweak:add("input", myDebugTable, 'myColor')

-- Create a simple line monitor
tweak:add("monitor", myDebugTable, 'Wave', {
  view = 'graph',
  min = 1,
  max = 100,
})

-- Update Monito Value
addEventHandler("onClientPreRender", root, function () 
  gui:setMonitorValue('Wave', getCurrentFPS())
end)


-- Print in Console the updated values
addCommandHandler("get", function () 
  iprint(myDebugTable)
end)
