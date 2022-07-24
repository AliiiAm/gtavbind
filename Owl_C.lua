local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)
local font =  dxCreateFont("f.ttf", x*50)
local font2 =  dxCreateFont("f.otf", x*20)

defaultMS = 4000
listBinds = {} -- List of binds, so we can add more than one (but not two on the same key, since that's silly) [bind] = {name}
listTimers = {} -- List of timers that makes the buttons stop rendering
rendering = false -- This boolean will tell you when are we rendering the text or not, this WILL save CPU time, specially on low end systems


--[[
/////////////////////////
//// RENDERING STUFF ////
/////////////////////////
]]--

function render()
	-- This should NEVER happend, but just in case we leave it here
	if not rendering then
		removeEventHandler("onClientRender", root, render)
		return
	end
	
	local y1 = 0 -- Y axis multiplicator, so we can show more than one button
	for bind,name in pairs(listBinds) do
		local spacing = y1*(y*40)
		AliRect(x*10, y*30 + spacing, x*230, y*35, 2, tocolor(0, 0, 0, 200)) 
		AliRect(x*55, y*32 + spacing, x*30, y*30, 5, tocolor(255, 255, 255, 255)) 
		dxDrawText("Press", x*15, y*37 + spacing, x*100, y*100 + spacing, tocolor(255, 255, 255), 0.21, 0.21, font)
		dxDrawText(bind, x*64, y*35 + spacing, x*100, y*100 + spacing, tocolor(0, 0, 0), 0.8, 0.8, font2)
		dxDrawText("to access "..name, x*90, y*37 + spacing, x*100, y*100 + spacing, tocolor(255, 255, 255), 0.21, 0.21, font)
		-- I deleted ``to acces THE`` since most of the times THE is unnecesary
		
		y1 = y1+1
	end
end

function startRendering()
	if rendering then
		return
	end
	
	addEventHandler("onClientRender", root, render)
	rendering = true
end

function stopRendering()
	if not rendering then
		return
	end
	
	rendering = false
	removeEventHandler("onClientRender", root, render)
end

--[[
/////////////////////////////////////////////
//// EVENTS // ADDING AND REMOVING BINDS ////
/////////////////////////////////////////////
]]--

addEvent("addgtavbind",true)
addEventHandler("addgtavbind", root, function(n,b,ms)
	-- Users could pass other things that are not strings, and that will make our code not work
	if type(n) ~= "string" or type(b) ~= "string" then
		iprint("Unable to add GTA V bind: ", n, b, ms)
		return false
	end
	
	if isTimer(listTimers[b]) then
		killTimer(listTimers[b])
		listTimers[b] = nil
	end
	
	-- Add to the list
	listBinds[b] = n
	
	-- If there is not a time set, use the default time
	if not ms then
		ms = defaultMS
	end
	
	-- Sometimes you don't want to make it dissapear
	-- If ms is passed as 0 or a negative number, then it won't destroy by itself (you will need to use `removegtavbind`)
	if type(ms) == "number" and ms > 0 then
		listTimers[b] = setTimer(deleteGTAVBind, ms, 1, b)
	end
	
	-- Start rendering
	startRendering()
end)

function deleteGTAVBind(b)
	listBinds[b] = nil
	listTimers[b] = nil
	
	for k,v in pairs(listBinds) do
		-- If there is a single bind, then we don't stop rendering
		return
	end
	
	-- Otherwise we stop
	stopRendering()
end
addEvent("removegtavbind",true)
addEventHandler("removegtavbind", root, deleteGTAVBind)

--[[
//////////////
//// UTIL ////
//////////////
]]--

function AliRect(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end

--test code
--[[
addCommandHandler("bindtest", function()
	triggerEvent("addgtavbind",localPlayer,"MTA","E")
end)
]]