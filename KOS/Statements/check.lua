function State:Check(txt, line, block, dir)
    if txt:find('if ') and not txt:find('elif ') then
        State:New(txt, line, block, dir)
    end
end