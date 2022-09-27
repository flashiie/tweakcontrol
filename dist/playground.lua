 --[[
    @author Vítor "flashii" Ribeiro
    @copyright (c) MIT
    @license See mode on https://rocketmta.com
--]]

local tweak = TweakControlClass(12, "Movie")
local tweak2 = TweakControlClass(123, "Maker")


local myDebugTable = {
  MyText = "Flashii",
  ToggleLogo = true,
  RotateLogo = 0,
  myColor = "#fff",
  Wave = 0
}

-- -- Add Input Text of String
tweak:add("input", myDebugTable, 'MyText')
tweak2:add("input", myDebugTable, 'MyText')


-- --- Add Boolean Input-Type
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
  max = getFPSLimit(),
})

-- Update Monito Value
addEventHandler("onClientPreRender", root, function () 
  tweak:setMonitorValue('Wave', getCurrentFPS())
end)


-- Print in Console the updated values
addCommandHandler("get", function () 
  iprint(myDebugTable)
end)
