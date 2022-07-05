local function GetLines(names)
    local nums = {}
    for _, i in ipairs(Func) do
      if inList(i.name, names) then
        local first = i.lines[1] 
        local second = i.lines[2]
        local current = first
        while current <= second do
          table.insert(nums, current)
  
          current = current + 1
        end
      end
    end
    return nums
end
function Func:Called(txt,line, dir)
    for _, i in ipairs(Func) do
        if txt:find(i.name:gsub('%(',''):gsub('%)','')) and txt:find('%(')  and txt:find('%)') and not txt:find('fun ') then
            self:GetVars(i.name, txt, line)
            self:Execute(i.name,i.dir)
        end
    end
end
function Func:GetVars(name, txt, line)
    local values = split(split(txt, '%(')[2]:gsub('%)',''):sub(1,-2),',')
    if values[1]:gsub(' ','') == '' then return end
    for _, i in ipairs(values) do
        i = Vars:CheckValue(i)
    end
    for _, i in ipairs(Func) do
        if i.name == name then
            for index,j in ipairs(split(i.args,',')) do
                for _, k in ipairs(Vars) do 
                    if removeSpaces(j):gsub(' ','') == k.name  then k.value = values[index] break end
                end
                for _, v in ipairs(Vars) do
                    if v.name == removeSpaces(values[index]) then
                        values[index] = v.value
                    end
                end
                local info = {
                    name = removeSpaces(j):gsub(' ',''),
                    value = values[index],
                    decorations = 'local',
                    block = removeSpaces(name),
                    line = line,
                    forType = removeSpaces(name),
                    type = Vars:CheckType(values[index]),
                }
                table.insert(Vars, info)
            end
        end
    end
end
function Func:Execute(name,dir)
    for _,i in ipairs(readFile(dir))do
        if  inList(_,GetLines({name})) and countSpaces(i) == 4 and not inList(_, Comments) then 
            State:Check(i,_, name,dir)
            List:Check(i,_,name , dir)
            While:Check(i,_,name , dir)
            Operator:Check(i,_,name,dir)
            Vars:Check(i,_,name,dir )
            Print:Check(i,_, name,dir)
            For:Check(i,_,name, dir)
            if Return:Check(i,_,name, dir) then  self:RemoveLocal(name) return end
        end
    end
    self:RemoveLocal(name)
end
function Func:RemoveLocal(name)
    for _, i in ipairs(Vars) do
        if i.forType == name then
            table.remove(Vars, _)
            self:RemoveLocal(name)
        end
    end
end