 --[[
    @author Vítor "flashii" Ribeiro
    @copyright (c) MIT
    @license See mode on https://rocketmta.com
--]]


local twakcontrol = {}
local private = {}
setmetatable(private, {__mode = 'k'});

local scale, screenX, screenY = getScaleValue()

-- dev
setDevelopmentMode(false, false)

function twakcontrol:new(title)
  local instance = {}

  instance.title = title or "Controls"
 
  setmetatable(instance, {__index = self })

  private[instance] = {}
  setmetatable(private[instance], {__index = private})

  private[instance].isReady = false
  private[instance].default = {}
  private[instance].datas = {}
  private[instance].browser = guiGetBrowser(guiCreateBrowser(0, 0, 270, screenY, true, true, false))

  if (private[instance].browser) then
    addEventHandler("onClientBrowserCreated", private[instance].browser, function()
      loadBrowserURL(source, "http://mta/local/src/3rd-party/ui.html")
    end)

    addEventHandler("onClientBrowserDocumentReady", private[instance].browser, function () 
      private[instance].isReady = true
      executeBrowserJavascript(private[instance].browser, "const pane = new Tweakpane.Pane({ title: '"..instance.title.."'});")
    end)

    addEvent("twakcontrol:updateValue", true)
    addEventHandler("twakcontrol:updateValue", root, function (store)
      local getStore = fromJSON(store)
      private[instance].default[getStore.key] = getStore.value
    end)
  end

  return instance
end


function twakcontrol:add(type, table, name, options)
  if (not type or not table or not name) then 
    return warn("tweakcontrol: informations has not provided")
  end

  private[self].default = table
  
  addEventHandler("onClientBrowserDocumentReady", private[self].browser, function () 
    local toStore = {
      type = type,
      name = name,
      value = table[name],
      options = options
    }
    executeBrowserJavascript(private[self].browser, 'add('..toJSON(toStore)..')')
  end)
end

function twakcontrol:setMonitorValue(name, value) 
  if not (table or name) then 
    return warn("tweakcontrol: informations has not provided")
  end

  private[self].default[name] = value

  local toStore = {
    name = name,
    value = value
  }

  if (private[self].isReady) then 
    executeBrowserJavascript(private[self].browser, 'setMonitorValue('..toJSON(toStore)..')')
  end
end

function TweakControlClass(title)
  return twakcontrol:new(title)
end

function warn(message)
  return error(tostring(message), 2)
end