function For:CalledList(lines,dir,vars, spaces, list,block)
    local count = 1
    while count <= #list do 
        self:ChangeVar(vars, lines[1], dir..'/'..block, count, list)
        for _, i in ipairs(readFile(dir)) do
            if  not inList(_, Comments) and _ > lines[1] and _ <= lines[2] then
                if countSpaces(i) == spaces + 4 then
                    List:Check(i,_,block , dir)
                    While:Check(i,_,block , dir)
                    State:Check(i,_,block , dir)
                    Operator:Check(i,_,block, dir)
                    Vars:Check(i,_,block,dir)
                    Print:Check(i,_,block,dir)
                    For:Check(i,_,block, dir)
                    Func:Check(i, _, dir)
                    Func:Called(i,_,dir)
                    if Return:Check(i,_,block, dir) then return end
                end
            end
        end
        count = count + 1
    end
    if #vars == 2 then
        for _, i in ipairs(vars) do
            for index, j in ipairs(Vars) do
                if i:gsub(' ','') == j.name  then 
                    table.remove(Vars, index)
                end
            end
        end
    else
        for index, j in ipairs(Vars) do
            if vars:gsub(' ','') == j.name then 
                table.remove(Vars, index)
            end
        end
    end
end
function For:ChangeVar(vars, lines, dir, count, list)
    if #vars == 2 then
        for _, i in ipairs(vars) do
            for _, j in ipairs(Vars) do
                if removeSpaces(i):find(j.name) and dir == j.block then 
                    if j.forType == 'index' then j.value = count 
                    elseif j.forType == 'var' then j:update(list[count])
                    end
                end
            end
        end
    else
        for _, j in ipairs(Vars) do
            if removeSpaces(vars):find(j.name) and dir == j.block then 
                if j.forType == 'var' then j.value = list[count] end
            end
        end
    end
end