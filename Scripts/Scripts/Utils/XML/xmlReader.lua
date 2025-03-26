
--WH_NOMASTER_START
--[[

-- Original Lua XML reader
-- Written by Roberto Ierusalimschy
-- http://lua-users.org/wiki/LuaXml
-- [Edited]

xmlReader = {}

function xmlReader.parseattr(s)
  local arg = {}
  string.gsub(s, "([a-zA-Z0-9_]+)=([\"'])(.-)%2", function (w, _, a)
    arg[w] = a
  end)
  return arg
end
    
function xmlReader.collect(s)
  local stack = {}
  local top = {}
  table.insert(stack, top)
  local ni,c,label,attrs, empty
  local i, j = 1, 1
  while true do
    ni,j,c,label,attrs, empty = string.find(s, "<(%/?)([%w:]+)(.-)(%/?)>", i)
    if not ni then break end
    local text = string.sub(s, i, ni-1)
    if not string.find(text, "^%s*$") then
      table.insert(top, text)
    end
    if empty == "/" then
      table.insert(top, {label=label, attrs=xmlReader.parseattr(attrs), empty=1})
    elseif c == "" then 
      top = {label=label, attrs=xmlReader.parseattr(attrs)}
      table.insert(stack, top)
    else  -- end tag
      local toclose = table.remove(stack)
      top = stack[#stack]
      if #stack < 1 then
        error("[XML Parser] Cannot close label '" .. label .. "'.")
      end
      if toclose.label ~= label then
      	error("[XML Parser] Attempted to  close label '" .. toclose.label .. "' with '" .. label .. "'.")
      end
      table.insert(top, toclose)
    end
    i = j+1
  end
  local text = string.sub(s, i)
  if not string.find(text, "^%s*$") then
    table.insert(stack[#stack], text)
  end
  if #stack > 1 then
    error("[XML Parser] Unclosed " .. stack[#stack].label .. ".")
  end
  return stack[1]
end

]]--
--WH_NOMASTER_END
