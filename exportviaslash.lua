exportviaslash = LibStub("AceAddon-3.0"):NewAddon("AceEvent-3.0")

--------------- WoW base64 Decode function ------------------
local encodedByte = {
  'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',
  'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
  '0','1','2','3','4','5','6','7','8','9','+','/'
}

local decodedByte = {}

for i=1,#encodedByte do
  local b = string.byte(encodedByte[i])
  decodedByte[b] = i - 1
end

function wow_decode_bitmap(bitmap)
  local index = 1
  local bits_enabled = {}

  for i=1, string.len(bitmap) do
    local b = decodedByte[string.byte(bitmap, i)]
    local v = 1

    for j=1,6 do
      if bit.band(v, b) == v then
        bits_enabled[#bits_enabled+1] = index
      end

      v = v * 2
      index = index + 1
    end
  end

  return bits_enabled
end

--------------- end of WoW base64 Decode function ------------------

basicTradeID = {}

local function buildBasicTradeTable(aliases)
  for n=1,#aliases do
    basicTradeID[aliases[n]] = aliases[1]
  end
end

SpellsMap = {}

function exportviaslash:OnInitialize()
  buildBasicTradeTable({ 2259,3101,3464,11611,28596,28677,28675,28672,51304,80731 })            -- alchemy
  buildBasicTradeTable({ 2018,3100,3538,9785,9788,9787,17039,17040,17041,29844,51300,76666 })   -- blacksmithing
  buildBasicTradeTable({ 7411,7412,7413,13920,28029,51313,74258 })                              -- enchanting
  buildBasicTradeTable({ 4036,4037,4038,12656,20222,20219,30350,51306,82774 })                  -- eng
  buildBasicTradeTable({ 45357,45358,45359,45360,45361,45363,86008 })                           -- inscription
  buildBasicTradeTable({ 25229,25230,28894,28895,28897,51311,73318 })                           -- jc
  buildBasicTradeTable({ 2108,3104,3811,10656,10660,10658,10662,32549,51302,81199 })            -- lw
  buildBasicTradeTable({ 3908,3909,3910,12180,26801,26798,26797,26790,51309, 75156 })           -- tailoring
  buildBasicTradeTable({ 2550,3102,3413,18260,33359,51296,88053 })                              -- cooking
  buildBasicTradeTable({ 3273,3274,7924,10846,27028,45542,74559 })                              -- first aid
end

function exportviaslash:OnEnable(first)
end

SLASH_EXPORTVIASLASH1 = "/exportviaslash";

function blank(str)
  return str == nil or str == '' or (not str)
end

function SlashCmdList.EXPORTVIASLASH(msg)
  local version, build = GetBuildInfo()
  local professions = {}

  build = tonumber(build)

  if( SpellDataLookupTable[build] == nil ) then
    print("Your SpellDataLookupTable.lua does not contain info for build: #"..build)
    return false
  end

  if(blank(msg)) then
    msg = "all"
  end

  -- depending on profession name generate trade link where all bits are enabled
  if( msg == "all" or msg == nil or not msg ) then
    professions = {
      "blacksmithing", "tailoring", "inscription", "jewelcrafting", "alchemy",
      "leatherworking", "engineering", "enchanting", "cooking", "first_aid"
    }
  else
    professions = { msg }
  end

  for n=1, #professions do
    print("PRINTING ALL KNOWN RECIPES IN ", professions[n]);

    local my_link
    if( professions[n] == "blacksmithing" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:2018:2:75:380000003351CDF:" .. "/" .. string.rep("/", 87) .. "|h[Blacksmithing]|h|r" .. " TEST"
    elseif ( professions[n] == "tailoring" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:26798:426:450:380000001ACFFFB:" .. "/" .. string.rep("/", 73) .. "|h[Tailoring]|h|r" .. " TEST"
    elseif ( professions[n] == "inscription" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:45363:431:450:380000001ABD9F5:" .. "/" .. string.rep("/", 75) .. "|h[Inscription]|h|r" .. " TEST"
    elseif ( professions[n] == "jewelcrafting" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:51311:450:450:380000002A47F07:" .. "/" .. string.rep("/", 95) .. "|h[Jewelcrafting]|h|r" .. " TEST"
    elseif ( professions[n] == "alchemy" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:28677:450:450:380000002E39D99:" .. "/" .. string.rep("/", 44) .. "|h[Alchemy]|h|r" .. " TEST"
    elseif ( professions[n] == "leatherworking" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:51302:420:450:380000001B74BA8:" .. "/" .. string.rep("/", 91) .. "|h[Leatherworking]|h|r" ..  " TEST"
    elseif ( professions[n] == "engineering" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:51306:450:450:3800000007E3495:" .. "/" .. string.rep("/", 54) .. "|h[Engineering]|h|r" .. " TEST"
    elseif ( professions[n] == "enchanting" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:51313:450:450:380000002FDA45E:" .. "/" .. string.rep("/", 51) .. "|h[Enchanting]|h|r" .. " TEST"
    elseif ( professions[n] == "cooking" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:2550:450:450:380000002FDA45E:" .. "/" .. string.rep("/", 30) .. "|h[Cooking]|h|r" .. " TEST"
    elseif ( professions[n] == "first_aid" ) then
      my_link = "TEST " .. "|cffffd000|Htrade:3273:450:450:380000002FDA45E:" .. "/" .. string.rep("/", 5) .. "|h[First Aid]|h|r" .. " TEST"
    end

    print(my_link)

    local tradeID, skill_level, bitmap = string.match(my_link, "trade:(%d+):(%d+):%d+:[0-9a-fA-F]+:([A-Za-z0-9+/]+)")
    tradeID = tonumber(tradeID)

    if( SpellDataLookupTable[build][tradeID] == nil ) then
      tradeID = basicTradeID[tradeID]
    end

    print("TOTAL RECIPES IN LOOKUP BITMAP FOR THIS BUILD: ", #SpellDataLookupTable[build][tradeID] )
    bits_enabled = wow_decode_bitmap(bitmap)
    SpellsMap[professions[n]] = {}

    print(" TOTAL BITS ENABLED IN CUSTOM TRADESKILL LINK: ", #bits_enabled)
    for i,v in ipairs(bits_enabled) do
      -- print(i, " : ", v, " : ", SpellDataLookupTable[build][tradeID][v] )
      if( SpellDataLookupTable[build][tradeID][v] ~= nil ) then
        local spell_name = GetSpellInfo(SpellDataLookupTable[build][tradeID][v])
        SpellsMap[professions[n]]["" .. v ..""] =  { SpellDataLookupTable[build][tradeID][v],  spell_name }
      end
    end

    print("END PRINTING ALL KNOWN RECIPES IN ", professions[n]);
  end

  -- Commented out code that tested recipe => characters mapping approach
  -- print(SpellDataLookupTable, " : ", RecipeCharacters)
  -- local page_num, page_size = 0, 10
  -- for idx in pairs({1,2,3,4,5,6,7,8,9,10,11}) do
  --   print(RecipeCharacters["Copper Battle Axe"][idx])
  -- end
end
