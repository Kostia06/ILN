require 'require'

print()
alphabet = {'a', 'b', 'c', 'd', 'e', 'f', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y','z'}
numbers = {1,2,3,4,5,6,7,8,9,0}
expressions = {'%+', '%-', '%/', '%*', '%^'}
operators = {'+=', '-=', '*=', '/='}
inequalities = {'==', '!=', '<=', '>='}
buildinActions = {'index', 'type', '#'}
listActions = {'append', 'remove'}
debug = false

function printVars()
    for _, i in ipairs(Vars) do
        print(i.name, i.value, i.type, i.decorations, i.line, i.block)
    end
end
function printFunc()
    for _, i in ipairs(Func) do
        print(i.name, i.args, i.lines[1] .. '-' .. i.lines[2])
    end
end
function printFor()
    for _, i in ipairs(For) do
        print('for', i.lines[1] .. '-' .. i.lines[2])
    end
end
local function showData()
    print()
    print(string.rep('-', 60))
    printVars()
    printFunc()
    printFor()
    print(string.rep('-', 60))
end
function Main(dir)
    Read:Run(dir)
    if debug then showData() end
end



function CheckDir()
    io.write('File Directory:  ')
    local dir = io.read("*l")
    if dir:find('%,') then 
        debug = removeSpaces(split(dir, ',')[2])
        dir = removeSpaces(split(dir, ',')[1])
    end
    -- local dir =  'Examples/main.txt'
    if fileExists(dir) then
        Read:CheckDir(dir)
        Main(dir)
    else
        print('--------> No File Found <--------')
    end
end
CheckDir()