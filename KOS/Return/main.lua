Return = {}
function Return:New(txt, line,name, dir)
    txt = txt:gsub('return','')
    for _, i in ipairs(Vars) do
        if txt:find(i.name) then
            if checkBlock({i.block, name}, i.decorations, dir) then
                txt = txt:gsub(i.name, i.value)
            end
        end
    end
    txt = exe(removeSpaces(txt))
    name = name:gsub("%(",''):gsub('%)','')
    for _, i in ipairs(Vars) do
        if i.value:find(name .. '%(') or i.type == nil then
            i:update(txt)
            return true
        end 
    end
end