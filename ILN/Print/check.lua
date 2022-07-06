function Print:Check(txt, line,block,dir)
    if txt:find('print ') then
        self:New(txt,line,block,dir)
    end
end
function Print:CheckVar(txt,block,dir)
    txt = tostring(removeSpaces(txt))
    for _, var in ipairs(Vars) do
        if txt:find(removeSpaces(var.name))  then 
            if checkBlock({var.block, block}, var.decorations, dir) then 
                txt = txt:gsub(removeSpaces(var.name), var.value)
            end
        end 
    end
    return txt
end