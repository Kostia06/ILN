Read = {}
function Read:Run(dir)
    for _, i in ipairs(readFile(dir)) do Comments:Check(i,_) end
    for _,i in ipairs(readFile(dir)) do
        if not inList(_, Comments) then
            if countSpaces(i) ==0 then
                self:Check(i, dir)
                Func:Check(i, _, dir)
                List:Check(i,_,'any' , dir)
                While:Check(i,_,'any' , dir)
                State:Check(i,_,'any' , dir)
                Operator:Check(i,_,'any', dir)
                Vars:Check(i,_,'any',dir)
                Print:Check(i,_,'any',dir)
                For:Check(i,_,'any', dir)
                Func:Called(i,_,dir)
            end
        end
    end
end
function Read:CheckDir(dir)
    if fileExists(dir) then
        return true
    else
        return false
    end
end
