function Operator:Check(txt, line, block)
    if inList(txt, operators) then
        for _,i in ipairs(split(txt,';')) do
            self:New(i, line, block)
        end
    end
end