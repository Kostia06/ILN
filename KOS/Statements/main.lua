State = {}
function State:New(txt, line, block, dir)
    local spaces = countSpaces(txt)
    local finds  = self:FindStatements(line,spaces, dir)
    local lines = {line, self:FindEnd(line,spaces,finds, dir)}
    local blocks = self:FindBlocks(lines, spaces, finds, dir)
    local info = {
        name = 'if',
        lines = lines,
        blocks=blocks,
        spaces = spaces,
        block = block,
    }
    table.insert(State, info)
    self:Called(block, dir, lines[1], blocks, spaces)
end
function State:FindStatements(line, spaces, dir)
    local counter = 0
    for _,i in ipairs(readFile(dir)) do
        if _ >= line then
            if countSpaces(i) == spaces then
                if i:find('if ') or i:find('elif ') or i:find('else') then
                    counter =  counter + 1
                end
            end
        end
    end
    return counter
end
function State:FindEnd(line, spaces, counter, dir)
    local count = 0
    for _,i in ipairs(readFile(dir)) do
        if _ >= line then
            if countSpaces(i) == spaces and count ~= counter  then 
                if i:find('if ') or i:find('else') or i:find('elif ') then
                    count = count + 1
                end
            elseif count == counter then
                if countSpaces(lookAhead(_,dir)) == spaces and not inList(lookAhead(_,dir), {'if ','elif ','else'})  or lookAhead(_,dir)  then
                    return _+1
                end
            end
        end
    end
end
function State:GetLines(num)
    local nums = {}
    for _, i in ipairs(State) do
        for _, j in ipairs(i.blocks) do
            for _, k in ipairs(self:GetRange(j[1], j[2], num))do
                table.insert(nums, k)
            end
        end
    end
    return nums

end
function State:FindBlocks(lines, spaces, counter, dir)
    local blocks = {}
    local count = 0
    local list = {}
    for _,i in ipairs(readFile(dir)) do
        if  lines[1]<=_ and _<=lines[2]   then
            if  i:find('if ') or i:find('elif ') or i:find('else') then 
                if countSpaces(i) == spaces then
                    table.insert(list, _)
                end
            end
        end
    end
    table.insert(list, lines[2])
    for _, i in ipairs(list) do 
        if list[_+1] ~= nil then
            table.insert(blocks,{i, list[_+1]})
        end
    end
    return blocks
end
function State:GetRange(num1, num2,num)
    local nums = {}
        local first = num1 + num
        local second = num2 
        local current = first
        while current <= second do
          table.insert(nums, current)
          current = current + 1
    end
    return nums
end
