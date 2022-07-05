function Func:Check(txt, line, dir)
    if txt:find('fun ') then
        Func:New(txt, line, dir)
    end
end
