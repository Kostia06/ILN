function For:Check(txt, line, block, dir)
    if txt:find('for ') then
        self:New(txt,line,block, dir)
    end
end