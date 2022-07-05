
local into
function BuildIn:GetIndex(value, action) 
    local num = split(value, action)[2]:gsub('%(',''):gsub('%)','')
    local value =removeSpaces(split(value, action)[1]):gsub('\'',''):gsub('\"','')
    value = self:CheckVar(value)
    local type = Vars:CheckType(value)
    if type == 'list' then
        for _, i in ipairs(split(value, ',')) do 
            if _ == tonumber(num) then 
                 return tostring(i):gsub('%[',''):gsub('%]','') 
            end
        end
    else
        return value:sub(num,num)
    end
end