local function getImage(options)
    local options = options or {}
    local assetPath = options.path or "Nightfall/assets"
    local name = options.name or "image.png"
    local url = options.url
    
    if not url then
        warn("URL não fornecida")
        return nil
    end
    
    local fullPath = assetPath .. "/" .. name
    
    if isfolder and makefolder and writefile and isfile and getcustomasset then
        local success, result = pcall(function()
            if not isfolder("") then
                makefolder("")
            end
            
            if not isfolder(assetPath) then
                makefolder(assetPath)
            end
            
            if not isfile(fullPath) then
                local data = game:HttpGet(url)
                writefile(fullPath, data)
            end
            
            return getcustomasset(fullPath)
        end)
        
        if success and result then
            return result
        end
    end
    
    warn("Using url: " .. url)
    return url
end
