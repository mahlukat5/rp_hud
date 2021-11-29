sx,sy = guiGetScreenSize()
SAFEZONE_X = sx*0.02
SAFEZONE_Y = sy*0.12
renkler = {
	["siyah"] = tocolor(0,0,0,255),
	["beyaz"] = tocolor(255,255,255,255),
	["can"] = tocolor(255,0,0,255),
	["zirh"] = tocolor(90,165,200,255),
	["aclik"] = tocolor(205,103,0,255),
	["su"] = tocolor(0,143,187,255),
	["para"] = tocolor(18,140,8,255),
	["level"] = tocolor(252,123,3,255),
}
positions = {
	["heart"] = {
		x=sx-(30),
		y=25,
		g=15,
		u=15,
	},
	["zirh"] = {
		x=sx-(30)-152,
		y=24*2,
		g=15,
		u=15,
	},
	["hunger"] = {
		x=sx-(30),
		y=24*3,
		g=15,
		u=15,
	},
	["water"] = {
		x=sx-(30)-152,
		y=24*4 - 1,
		g=15,
		u=15,
	},
	["dollar"] = {
		x = sx-(30),
		y=24*5 - 2,
		g=15,
		u=15
	},
	["level"] = {
		x=sx-(30)-152,
		y=24*6 - 3,
		g=15,
		u=15
	},
}
function drawCircle(posX,posY,radius,startAngle,stopAngle,theColor,theCenterColor,segments,ratio,postGUI)
	dxDrawCircle2(posX,posY,radius*2,radius*2,theColor,0,360)
	dxDrawCircle2(posX,posY,radius*2,radius*2,renkler["siyah"],0,stopAngle,5)
end
function drawCircle2(posX,posY,radius,color,backcolor)
	local g = radius*2
	local g2 = g-(g*0.2)
	dxDrawImage(posX-(g/2),posY-(g/2),g,g,pics["circle"],0,0,0,backcolor or renkler["siyah"])
	dxDrawImage(posX-(g2/2),posY-(g2/2),g2,g2,pics["circle"],0,0,0,color)
end
function dxDrawRoundedRectangle3(radius,x,y,w,h,color,postGUI,subPixel,noTL,noTR,noBL,noBR)
	local noTL = not noTL and dxDrawCircle(x+radius,y+radius,radius,180,270,color,color,9,1,postGUI) -- top left corner
	local noTR = not noTR and dxDrawCircle(x+w-radius,y+radius,radius,270,360,color,color,9,1,postGUI) -- top right corner
	local noBL = not noBL and dxDrawCircle(x+radius,y+h-radius,radius,90,180,color,color,9,1,postGUI) -- bottom left corner
	local noBR = not noBR and dxDrawCircle(x+w-radius,y+h-radius,radius,0,90,color,color,9,1,postGUI) -- bottom right corner
	dxDrawRectangle(x+radius-(not noTL and radius or 0),y,w-2*radius+(not noTL and radius or 0)+(not noTR and radius or 0),radius,color,postGUI,subPixel) -- top rectangle
	dxDrawRectangle(x,y+radius,w,h-2*radius,color,postGUI,subPixel) -- center rectangle
	dxDrawRectangle(x+radius-(not noBL and radius or 0),y+h-radius,w-2*radius+(not noBL and radius or 0)+(not noBR and radius or 0),radius,color,postGUI,subPixel)-- bottom rectangle
end
function dxDrawRoundedRectangle(x, y, rx, ry, color, radius)
	local lx, ly, px, py = rx,ry, x,y
    rx = rx - radius * 2
    ry = ry - radius * 2
    x = x + radius
    y = y + radius

    if (rx >= 0) and (ry >= 0) then
        dxDrawRectangle(x, y, rx, ry, color)
        dxDrawRectangle(x, y - radius, rx, radius, color)
        dxDrawRectangle(x, y + ry, rx, radius, color)
        dxDrawRectangle(x - radius, y, radius, ry, color)
        dxDrawRectangle(x + rx, y, radius, ry, color)

        dxDrawCircle(x, y, radius, 180, 270, color, color, 7)
        dxDrawCircle(x + rx, y, radius, 270, 360, color, color, 7)
        dxDrawCircle(x + rx, y + ry, radius, 0, 90, color, color, 7)
        dxDrawCircle(x, y + ry, radius, 90, 180, color, color, 7)
	else
		dxDrawRectangle(px, py, lx, ly, color)
    end
end
function dxDrawRoundedRectangle2(x, y, w, h, borderColor, bgColor, postGUI)
	if (x) and (y) and (w) and (h) then
		borderColor = borderColor or tocolor(0, 0, 0, 200)
		bgColor = bgColor or borderColor
	
		--> Background
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		
		--> Border
		dxDrawRectangle(x - 1, y + 1, 1, h - 2, borderColor, postGUI)-- left
		dxDrawRectangle(x + w, y + 1, 1, h - 2, borderColor, postGUI)-- right
		dxDrawRectangle(x + 1, y - 1, w - 2, 1, borderColor, postGUI)-- top
		dxDrawRectangle(x + 1, y + h, w - 2, 1, borderColor, postGUI)-- bottom
		dxDrawRectangle(x, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x, y + h - 1, 1, 1, borderColor, postGUI)
		dxDrawRectangle(x + w - 1, y + h - 1, 1, 1, borderColor, postGUI)
	end
end
function tocomma(number)
	while true do
		number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return number
end
function isData(elm,data)
	return getElementData(elm,data)
end
function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

function showToolTips(x,y,g,text,text2,corner_color)
	if isMouseInCircle(x, y, g) then
		local f =(g^2)
		tooltip((x-g),(y)-g*2,text,text2,corner_color)
	end
end

function isMouseInCircle(x, y, r)
    if isCursorShowing() then
        local cx, cy = getCursorPosition( )
        local cx, cy = cx*sx, cy*sy
        return (x-cx)^2+(y-cy)^2 <= r^2
    end
    return false
end
local tooltip_background_color = tocolor( 0, 0, 0, 180 )
local tooltip_corner_color = tocolor( 255, 255, 255, 180 )
local tooltip_text_color = tocolor( 255, 255, 255, 255 )
--MAXIME / SHOW TOOLTIP AT CURSOR POSITION
function tooltip( x, y, text, text2,corner_color )
	text = tostring( text )
	if text2 then
		text2 = tostring( text2 )
	end
	
	if text == text2 then
		text2 = nil
	end
	
	local width = dxGetTextWidth( text, 1, "clear" ) + 10
	if text2 then
		width = math.max( width, dxGetTextWidth( text2, 1, "clear" ) + 20 )
		text = text .. "\n" .. text2
	end
	local height = 5 * ( text2 and 5 or 3 )
	x = math.max( 5, math.min( x, sx - width - 5 ) )
	y = math.max( 5, math.min( y, sy - height - 5 ) )
	
	dxDrawRoundedRectangle2( x, y, width, height, corner_color or tooltip_corner_color,tooltip_background_color,true)
	-- dxDrawRoundedRectangle( x-2, y-2, width+4, height+4, corner_color or tooltip_corner_color,11)
	dxDrawText( text, x, y, x + width, y + height, tooltip_text_color, 1, "clear", "center", "center", false, false, true )
end

