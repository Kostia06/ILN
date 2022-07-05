function Comments:Check(txt, line)
    if txt:find('->') then
        table.insert(Comments, line)
    end
end
