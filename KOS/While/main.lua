While = {}
function While:New(txt,line,block, dir)
    local spaces = countSpaces(txt)
    local lines = {line, self:FindEnd(dir, line,spaces )-1}
    local statement = removeSpaces(txt:gsub('while ',''))
    self:Execute(dir, statement, block, spaces, lines)
end
function While:FindEnd(dir,line, spaces)
    for _,i in ipairs(readFile(dir)) do
        if _ > line then
            if countSpaces(i) == spaces and i ~= '' or countSpaces(i) < spaces then return _ end
        end
    end
end
function While:Execute(dir, line,block, spaces, lines)
    while self:FindTrue(line,dir, block) do
        for _, i in ipairs(readFile(dir)) do
            if not inList(_, Comments) and _ > lines[1] and _ <= lines[2] then 
                if countSpaces(i) == spaces + 4 then
                    List:Check(i,_,block , dir)
                    While:Check(i,_,block , dir)
                    State:Check(i,_,block, dir)
                    Operator:Check(i,_,block, dir)
                    Vars:Check(i,_,block,dir)
                    Print:Check(i,_,block,dir)
                    For:Check(i,_,block, dir)
                    Func:Called(i,_,dir)
                end
            end
        end
    end
end
function While:FindTrue(line, dir, block)
    for _, i in ipairs(Vars) do 
        if line:find(i.name) then 
            if checkBlock({i.block, block}, i.decorations, dir) then 
                line = line:gsub(i.name, i.value) 
            end
        end 
    end
    return exe(line)
end