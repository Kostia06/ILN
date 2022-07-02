
function Vars:Check(txt, line,block,dir)
    if txt:find('=') and not inList(txt,inequalities) and not inList(txt, operators) then
        for _,i in ipairs(split(txt,';')) do
            self:New(i,line,block,dir)
        end
    end
end
function Vars:GetTypes(names)
    if type(names) == 'table' then
        local list = ''
        for _, i in ipairs(names) do
            for _,j in ipairs(Vars) do
                if i == j.name then
                    list = list .. j.type
                end
            end  
        end
        return list
    else
        for _, i in ipairs(Vars) do 
            if names == i.name then return i.type end
        end
    end
end
function Vars:GetValues(names)
    if type(names) == 'table' then
        local list = ''
        for _, i in ipairs(names) do
            for _,j in ipairs(Vars) do
                if i == j.name then
                    list = list .. j.value
                end
            end  
        end
        return list
    else
        for _, i in ipairs(Vars) do 
            if names == i.name then return i.value end
        end
    end
end