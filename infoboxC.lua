--[[
********************************************************************************
	Project owner:		Sanyi
	Project name: 		Tutorial MTA
	Developers:   		Sanyi
	Version:    		v1.0 Open Source
	Status:     		Stable release
********************************************************************************
--]]

local sX, sY = guiGetScreenSize()
local pW, pH = 300, 35
local pX, pY = sX/2-pW/2, pH/2
local font = dxCreateFont("files/font.ttf",8)

local status = true
local animationY = -50
local alpha = 0

local infos = {}

function renderBox()
	if not status then return end
	for k,v in ipairs(infos) do
	
	animationY = animationY+5
	if animationY > 5 then
		animationY = 5
	end	
	
	alpha = alpha+10
	if alpha > 255/100*85 then
		alpha = 255/100*85
	end		
	
	length = dxGetTextWidth(v[2])
	pX = sX/2-length/2
	
	dxDrawRectangle(pX,animationY+(k*40),35+length+10,pH,tocolor(0,0,0,alpha)) -- bg
	dxDrawRectangle(pX,animationY+(k*40),35,pH,tocolor(0,0,0,alpha))
	dxDrawText(v[2],pX+40,animationY+(k*40)+10,35+length+5,pH,tocolor(255,255,255,255),1,font, "left", "top", true, true, true, true, true)
	dxDrawImage(pX+5,animationY+(k*40)+5, 24, 24, "files/" .. v[1] .. ".png")
	
		if v[3] + 10000 < getTickCount() then
			table.remove(infos, k)
		end	
	end
end
addEventHandler("onClientRender", root, renderBox)

function add_info(cmd,typ,...)
	if #infos + 1 > 4 then return end
	local msg = table.concat({...}, " ")
	if not ... then return end
	infos[#infos + 1] = {tonumber(typ),msg, getTickCount()}
end
