local EVP = CreateFrame("Frame")

function SetViewport()
	local scale = 768 / select(2, GetPhysicalScreenSize())

	WorldFrame:SetPoint("TOPLEFT", EVP.db.left * scale, -(EVP.db.top * scale))
	WorldFrame:SetPoint("BOTTOMRIGHT", -(EVP.db.right * scale), EVP.db.bottom * scale)
end

local defaultOptions = {
	top		= 0,
	bottom	= 0,
	left	= 0,
	right	= 0,
}

local function LoadDB()
	EVP.db = EsViewport_Options or defaultOptions
	EsViewport_Options = EVP.db
	SetViewport()
end

local help = {
	"/evp reset - Resets values to 0.",
	"/evp position # - top/bottom/left/right",
	"e.g. /evp bottom 100",
}

SlashCmdList.EVP = function(msg)
	msg = string.lower(msg)

	local _, _, cmd, val = string.find(msg, "^(%S*)%s*(.-)$")

	if cmd == "reset" then
		EsViewport_Options = defaultOptions
		LoadDB()
	elseif (cmd == "top" or cmd == "bottom" or cmd == "left" or cmd == "right") and tonumber(val) then
		EVP.db[cmd] = val
	else
		for _, v in ipairs(help) do
			print("|cffffff00"..("%s"):format(tostring(v)).."|r")
		end
		return
	end

	SetViewport()
end
SLASH_EVP1 = "/evp"
SLASH_EVP2 = "/esviewport"
SLASH_EVP3 = "/viewport"

EVP:RegisterEvent("VARIABLES_LOADED")
EVP:SetScript("OnEvent", LoadDB)