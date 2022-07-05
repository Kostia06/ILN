local signs = {'=','>','<','~'}
function State:Called(block, dir, line, blocks, spaces)
    local work = self:FindTrue(blocks, spaces, block,dir)
    self:Execute(work, block, spaces,dir)
end
function State:Execute(lines,block, spaces,dir)
    if lines == nil then return end
    for _,i in ipairs(readFile(dir)) do
        if _ > lines[1] and _ <= lines[2] +1 and countSpaces(i) == spaces+4 then
            State:Check(i,_,block ,dir)
            List:Check(i,_,block , dir)
            While:Check(i,_,block , dir)
            Operator:Check(i,_,block,dir)
            Vars:Check(i,_,block,dir )
            Print:Check(i,_, block,dir)
            For:Check(i,_,block, dir)
            Func:Called(i, _, dir)
            if Return:Check(i, _, block, dir) then return end
        end
    end
end
function State:FindTrue(blocks, spaces, block, dir)
    local line 
    for _, j in ipairs(blocks) do
        for index,k in ipairs(readFile(dir)) do
            if index >= j[1] and index <= j[2]-1 then
                k = k:gsub('!=', '~=')
                if k:find('if ') and not k:find('elif ') and countSpaces(k) == spaces then
                    k = k:gsub('if ','')
                    for _, v in ipairs(Vars) do
                        if k:find(v.name) then 
                            if checkBlock({v.block, block}, v.decorations, dir) then
                                k = k:gsub(v.name, v.value) 
                            else
                                return
                            end
                        end
                    end
                    k = removeSpaces(BuildIn:Check(k, block))
                    if not inList(removeSpaces(k):sub(1, 1), signs) then
                        if exe(tostring(k)) then return {j[1], j[2] - 1} end
                    end
                elseif k:find('elif ') and countSpaces(k) == spaces then
                    k = k:gsub('elif ','')
                    for _, v in ipairs(Vars) do
                        if k:find(v.name..' ') then k = k:gsub(v.name, v.value) end
                    end
                    k = removeSpaces(BuildIn:Check(k, block))
                    if not inList(removeSpaces(k):sub(1, 1), signs) then
                        if exe(tostring(k)) then return {j[1], j[2] - 1} end
                    end
                elseif k:find('else') and countSpaces(k) == spaces then  return{j[1], j[2]-1}
                end
            end
        end
    end
end
function State:FindLines(lines)
    local list = {}
    for _, i in ipairs(State) do
        if lines[1] ~= i.lines[1] and lines[2]~= i.lines[1] then
            -- print(i.lines[1], i.lines[2])
            for _, j in ipairs(self:GetRange(i.lines[1], i.lines[2], 0)) do
                table.insert(list, j)
            end
        end
    end
    return list
end
