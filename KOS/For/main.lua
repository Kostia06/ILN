For = {}
function For:New(txt,line,block, dir)
    local vars = split(split(txt:gsub('for',''),'in')[1],',')
    if vars[2] == nil then vars = vars[1] end
    local arg = removeSpaces(split(txt:gsub('for',''),'in')[2])
    local spaces = countSpaces(txt)
    local lines = {line, self:FindEnd(line,spaces , dir)-1}
    self:CreateVars(vars, arg,block, dir, lines, spaces)
end
function For:CreateVars(vars,arg, block, dir, lines, spaces)
    if self:CheckType(arg, block, dir) == 'list' then
        if #vars == 2 then
            self:CreateIndex(removeSpaces(vars[1]), lines, dir, block)
            self:CreateVar(removeSpaces(vars[2]), lines, dir, block)
        else
            self:CreateVar(removeSpaces(vars), lines, dir, block)
        end
        self:CalledList(lines, dir,vars, spaces, self:FindList(arg),block)
    elseif self:CheckType(arg, block, dir) == 'str'  then
        if #vars == 2 then
            self:CreateIndex(removeSpaces(vars[1]), lines, dir, block)
            self:CreateVar(removeSpaces(vars[2]), lines, dir, block)
        else
            self:CreateVar(removeSpaces(vars), lines, dir, block)
        end
        local list = stringList(self:CheckVar(arg, block, dir))
        self:CalledList(lines, dir,vars, spaces, list,block)
    elseif self:CheckType(arg, block, dir) == 'int' then
        if #vars == 2 then return end
        self:CreateVar(removeSpaces(vars), lines, dir, block)
        local list = numberList(self:CheckVar(arg, block, dir))
        self:CalledList(lines, dir,vars, spaces, list,block)
    end
end
function For:CreateIndex(var, lines, dir, block)
    local info = {
        name = removeSpaces(var):gsub(' ',''),
        value = '',
        type = 'int',
        decorations = 'local',
        block = dir..'/'..block,
        line = lines[1],
        forType ='index',
        update = function(self,value)
            self.value = value
            self.type = Vars:CheckType(self.value)
        end,
    }
    table.insert(Vars, info)
end
function For:CreateVar(var, lines, dir, block)
    local info = {
        name = removeSpaces(var):gsub(' ',''),
        value = '',
        type = 'str',
        decorations = 'local',
        block = dir..'/'..block ,
        line = lines[1],
        forType = 'var',
        update = function(self,value)
            self.value = value
            self.type = Vars:CheckType(self.value)
        end,
    }
    table.insert(Vars, info)
end
function For:CheckType(var,block, dir)
    for _, i in ipairs(Vars) do 
        if removeSpaces(var):find(i.name) then 
            if checkBlock({i.block, block}, i.decorations, dir) then 
                return i.type
            end
        end 
    end
end
function For:FindEnd(line, spaces, dir)
    for _,i in ipairs(readFile(dir)) do
        if _ > line then
            if countSpaces(i) == spaces and i ~= '' or countSpaces(i) < spaces then return _ end
        end
    end
end
function For:FindList(var)
    local list 
    for _, i in ipairs(Vars) do
        if var:gsub(' ','') == i.name then
            list = split(i.value:gsub('%[',''):gsub('%]',''),',')
        end
    end
    return list
end
function For:CheckVar(txt,block,dir)
    txt = tostring(removeSpaces(txt))
    for _, var in ipairs(Vars) do
        if txt:find(var.name)  then 
            if checkBlock({var.block, block}, var.decorations, dir) then 
                txt = txt:gsub(var.name, var.value):gsub('\'',''):gsub('\"','')
            end
        end 
    end
    return txt
end
