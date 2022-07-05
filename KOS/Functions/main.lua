Func = {}
function Func:New(txt, line, dir)
    local name= removeSpaces(txt:gsub('fun ',''))
    local args = split(name, '%(')[2]:gsub('%)',''):sub(1,-2)
    local lines = {line, self:FindEnd(line,dir)-1}
    if args:sub(#args,#args) == ' ' then args = args:sub(1,-2) end
    local info = {
        name= name:gsub(tostring(args),''):gsub(' ',''),
        args =args,
        lines = lines,
        dir = dir,
        block = name,
    }
    table.insert(Func, info)
end
function Func:FindEnd(line,dir)
    for _,i in ipairs(readFile(dir)) do
        if _ > line then
            if countSpaces(i) == 0 then return _ end
        end
    end
end
function Func:GetLines()
    local nums = {}
    for _, i in ipairs(Func) do
        local first = i.lines[1] 
        local second = i.lines[2]
        local current = first
        while current <= second do
            table.insert(nums, current)
            current = current + 1
        end
    end
    return nums
end