Print = {}
function Print:New(txt, line, block,dir)
    local list = ''
    for _, i in ipairs(split(txt:gsub('print ', ''), ',')) do 
        if i == '' or i == nil then break end
        if i:find('\'') or i:find('\"') then list = list .. removeSpaces(tostring(i)) goto skip_to_next end
        i = removeSpaces(i)
        local value = self:CheckVar(i,block, dir)
        value = removeSpaces(BuildIn:Check(value,block))
        local type = Vars:CheckType(value)
        if type~='list' and inList(tostring(value), expressions) and not inList(value, alphabet) then value = self:math(value, block)  end
    
        list = list .. tostring(value)
        ::skip_to_next::
    end
    list = list:gsub('\'','')
    print(list)
end
function Print:math(name,block)
    return exe(name)
end