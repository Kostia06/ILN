function Read:Check(txt, dir)
    if txt:find('use ') and countSpaces(txt) == 0 then
        for _, i in ipairs(split(txt:gsub('use ',''),','))do
            self:New(i, dir)
        end
    end
end
function Read:New(txt, dir)
    dir = self:GetDir(dir)
    local file = removeSpaces(txt):gsub(' ',''):gsub('\'',''):gsub('\"','')..'.txt'
    if fileExists(dir .. file) then
        self:Run(dir .. file)
    else
        print('File Was Not Found: '..file)
    end
end
function Read:GetDir(dir)
    local file = ''
    for _, i in ipairs(split(dir,'/')) do
        if #split(dir, '/') ~= _ then
            file = file .. i .. '/'
        end
    end
    if file:sub(1,1) == '%/' then
        file = file:sub(2)
    end
    return file
end