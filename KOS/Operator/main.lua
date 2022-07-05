Operator = {}
function Operator:New(txt, line, block)
    local action 
    for _, i in ipairs(operators) do  if txt:find(i) then action = i break end end
    local value = self:GetValue(split(txt, action)[1],block)
    if value == nil then return end
    if Vars:CheckType(value) ~= 'int' then return end
    value = exe(value..action:sub(1,1)..split(txt, action)[2])
    self:ChangeValue(split(txt, action)[1], value)
end
function Operator:ChangeValue(name, value)
    for _, i in ipairs(Vars) do
        if removeSpaces(name):gsub(' ','') == removeSpaces(i.name) then
            i.value = value
        end
    end
end
function Operator:GetValue(value, block)
    for _, i in ipairs(Vars) do
        if removeSpaces(value):gsub(' ','') == removeSpaces(i.name) then
            if i.declarations == 'const' then return end
            if i.block == block or i.block == 'main' or i.declarations ~= 'local' then
                return i.value
            end
        end
    end
end