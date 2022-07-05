function List:Check(txt, line, block ,dir)
    if inList(txt, listActions) then
        self:New(txt,line,block, dir)
    end
end