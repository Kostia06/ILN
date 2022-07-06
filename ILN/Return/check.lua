function Return:Check(txt, line,name, dir)
    if txt:find('return') and self:FindFunc(name) then
        return self:New(txt, line,name, dir)
    end
end

function Return:FindFunc(name)
    for _, i in ipairs(Func) do
        if i.name == name then return true end
    end
end