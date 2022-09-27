 --[[
    @author Vítor "flashii" Ribeiro
    @copyright (c) MIT
    @license See mode on https://rocketmta.com
--]]


local twakcontrol = {}
local private = {}
setmetatable(private, {__mode = 'k'});

local scale, screenX, screenY = getScaleValue()
local browser = guiGetBrowser(guiCreateBrowser(0, 0, 270, screenY, true, true, false))
-- dev
setDevelopmentMode(true, true)

function twakcontrol:new(name, title)
  local instance = {}

  instance.name = 'folder_'..name or 'folder_'..math.random(0,36692)..''
  instance.title = title or "Controls"
 
  setmetatable(instance, {__index = self })

  private[instance] = {}
  setmetatable(private[instance], {__index = private})

  private[instance].isReady = false
  private[instance].default = {}
  private[instance].datas = {}


  if (#twakcontrol == 0) then
    addEventHandler("onClientBrowserCreated", browser, function()
      --toggleBrowserDevTools(browser, true)
      loadBrowserURL(source, "http://mta/tweakcontrol/src/3rd-party/ui.html")
    end)



    addEvent("twakcontrol:updateValue", true)
    addEventHandler("twakcontrol:updateValue", root, function (store)
      local getStore = fromJSON(store)
      private[instance].default[getStore.key] = getStore.value
    end)
  end


  addEventHandler("onClientBrowserDocumentReady", browser, function () 
      private[instance].isReady = true
      executeBrowserJavascript(browser, "makeFolder('"..instance.name.."', '"..instance.title.."')")
  end)

  table.insert(twakcontrol, self)
  return instance
end


function twakcontrol:add(type, table, name, options)
  if (not type or not table or not name) then 
    return warn("tweakcontrol: informations has not provided")
  end

  private[self].default = table
  
  addEventHandler("onClientBrowserDocumentReady", browser, function () 
    local toStore = {
      type = type,
      name = name,
      value = table[name],
      options = options
    }
    executeBrowserJavascript(browser, 'add("'..self.name..'", '..toJSON(toStore)..')')
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
    executeBrowserJavascript(browser, 'setMonitorValue('..toJSON(toStore)..')')
  end
end

local todo = [[local twakcontrol = {} local private = {} setmetatable(private, {__mode = 'k'}); local scale, screenX, screenY = getScaleValue() local browser = guiGetBrowser(guiCreateBrowser(0, 0, 270, screenY, true, true, false)) -- dev setDevelopmentMode(true, true) function twakcontrol:new(name, title) local instance = {} instance.name = 'folder_'..name or 'folder_'..math.random(0,36692)..'' instance.title = title or "Controls" setmetatable(instance, {__index = self }) private[instance] = {} setmetatable(private[instance], {__index = private}) private[instance].isReady = false private[instance].default = {} private[instance].datas = {} if (#twakcontrol == 0) then addEventHandler("onClientBrowserCreated", browser, function() --toggleBrowserDevTools(browser, true) loadBrowserURL(source, "http://mta/tweakcontrol/src/3rd-party/ui.html") end) addEvent("twakcontrol:updateValue", true) addEventHandler("twakcontrol:updateValue", root, function (store) local getStore = fromJSON(store) private[instance].default[getStore.key] = getStore.value end) end addEventHandler("onClientBrowserDocumentReady", browser, function () private[instance].isReady = true executeBrowserJavascript(browser, "makeFolder('"..instance.name.."', '"..instance.title.."')") end) table.insert(twakcontrol, self) return instance end function twakcontrol:add(type, table, name, options) if (not type or not table or not name) then return warn("tweakcontrol: informations has not provided") end private[self].default = table addEventHandler("onClientBrowserDocumentReady", browser, function () local toStore = { type = type, name = name, value = table[name], options = options } executeBrowserJavascript(browser, 'add("'..self.name..'", '..toJSON(toStore)..')') end) end function twakcontrol:setMonitorValue(name, value) if not (table or name) then return warn("tweakcontrol: informations has not provided") end private[self].default[name] = value local toStore = { name = name, value = value } if (private[self].isReady) then executeBrowserJavascript(browser, 'setMonitorValue('..toJSON(toStore)..')') end end function TweakControlClass(id, title) return twakcontrol:new(id, title) end function warn(message) return error(tostring(message), 2) end]]

function getTweakClass()
  return todo
end

function TweakControlClass(id, title)
  return twakcontrol:new(id, title)
end

function warn(message)
  return error(tostring(message), 2)
end