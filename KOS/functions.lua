
function fileExists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
  end

function readFile(file)
    if not fileExists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
  end

function writeFile(file, txt)
    local file = io.open(file, "a")
    file:write(txt, "\n")
end
function clearFile(file)
    io.open(file,"w"):close()
end
function scandir(directory)
    local  list, popen =  {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')

    for filename in pfile:lines() do
        table.insert(list, filename)
    end
    pfile:close()
    return list
end
function moveFile(from ,to)
    os.rename(from,to)
end
function split(s, delimiter)
	local result = {}
	for match in (s..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end
function removeQuotes(txt)
  if string.find(txt, "'") then return string.gsub(txt,'\'', '')
  else return string.gsub(txt,"\"", '')
  end
end
function inList(item, list)
    local item = tostring(item)
    for _,i in ipairs(list) do
        if item:find(i) then
            return true
        end
    end
    return false
end
function findWord(item, list)
  local pattern = string.format('^[%s]+$', item)
  for i,word in ipairs(list) do
      local matches = word:match(pattern)
      print(word, matches and 'matches' or 'does not match')
  end
end
function exe(equation)
  local func = assert(load("return " .. equation))
  return func()
end
function replaceChar(pos, str)
  return str:sub(1, pos-1)  .. str:sub(pos+1)
end
function removeSpaces(value)
    local counter = 1
    local list = {}
    local new = value
    if type(value) == 'number' then  
      if tostring(value):find(' ') then 
        return tostring(value):gsub(' ','') 
      else 
        return value 
      end 
    end
    if #tostring(value) > 1 then
      while true do
          if new:sub(counter,counter) == ' ' then  table.insert(list,counter)  counter = counter + 1  
          else
                for _, i in ipairs(list) do
                  new = new:sub(2)
                end
                return new

          end 
      end
    end
    return value
end
function countSpaces(value)
    local counter = 1
    local list = {}
    local new = tostring(value)
    if #tostring(value) > 1 then
      while true do
          if new:sub(counter,counter) == ' ' then  counter = counter + 1  
          else
            return counter - 1
          end 
      end
    end
    return counter -1
end
function checkBlock(blocks, decorations,dir)
    if decorations == 'local' then
      if blocks[1] ~= blocks[2] then
          return  false
      end
    end
    return true
end
function lookAhead(line,dir)
  for _,i in ipairs(readFile(dir)) do
      if _ - 1 == line then
          return i
      end
  end
  return true
end
function stringList(str)
    local list = {}
    for i=1, #str do
      list[i]= (string.sub(str,i,i))
    end
    return list
end
function numberList(num)
    local num = tonumber(num)
    local count = 1
    local list = {}
    while count <= num do 
      table.insert(list,count)
      count = count + 1
    end
    return list
end
strBoolean = {
    ["true"] = true,
    ["false"] = false
}
