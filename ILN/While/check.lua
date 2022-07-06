function While:Check(txt, line, block, dir)
    if txt:find('while ') then
        self:New(txt,line,block, dir)
    end
end