


local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)
local font =  dxCreateFont("f.ttf", x*50)
local font2 =  dxCreateFont("f.otf", x*20)

name =  "None"
st = false
tm = false

function render ()
if not st then
return
end
    AliRect(x*10,y*30 , x*230,y*35, 2, tocolor(0, 0, 0,200 )) 
    AliRect(x*55,y*32 , x*30,y*30, 5, tocolor(255, 255, 255,255 )) 
	dxDrawText ( "Press", x*15, y*37, x*100, y*100, tocolor ( 255, 255, 255 ), 0.21, 0.21, font )
	dxDrawText ( bind or "E", x*64, y*35, x*100, y*100, tocolor ( 0, 0, 0 ), 0.8, 0.8, font2 )
	dxDrawText ( "to access the "..name, x*90, y*37, x*100, y*100, tocolor ( 255, 255, 255 ), 0.21, 0.21, font )
	
	
end
addEventHandler("onClientRender", root, render	)

addEvent("addgtavbind",true)
addEventHandler("addgtavbind", root, function(n,b)

if isTimer(tm) then
killTimer(tm)
tm = nil
st = false
end

st = true
name = n
bind = b

tm = setTimer(function()
st = false
end, 4000,1)

end)

--test code
--[[
addCommandHandler("bindtest", function()
triggerEvent("addgtavbind",localPlayer,"MTA","E")
end)
]]








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

