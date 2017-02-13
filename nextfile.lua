local utils = require 'mp.utils'
local msg = require 'mp.msg'
local settings = {

    --filetypes,{'*mp4','*mkv'} for specific or {'*'} for all filetypes
    filetypes = {'*mkv','*mp4','*jpg','*gif','*png'}, 

    --linux(true)/windows(false)
    linux_over_windows = true,

    --at end of directory jump to start and vice versa
    allow_looping = true,

    --load next file automatically default value
    --recommended to keep as false and cycle with toggle or set with a script message
    --KEY script-message loadnextautomatically [true|false]
    --KEY script-binding toggleauto
    load_next_automatically = false,
}

function on_loaded()
    plen = tonumber(mp.get_property('playlist-count'))
    fullpath = utils.join_path(mp.get_property('working-directory'), mp.get_property('path'))
    file = mp.get_property("filename")
    path = string.sub(fullpath, 1, fullpath:len()-file:len())
end

function on_close(reason)
    if reason.reason == 'eof' and settings.load_next_automatically then
        msg.info("Loading next file in directory")
        nexthandler()
    end
end

function nexthandler()
	movetofile(true)
end

function prevhandler()
	movetofile(false)
end

function toggleauto()
    if not settings.load_next_automatically then
        settings.load_next_automatically = true
        if plen ~= 1 then 
            mp.osd_message("Playlist will be purged when next file is loaded")
        else
            mp.osd_message("Loading next when file ends")
        end
    else
        settings.load_next_automatically = false
        mp.osd_message("Not loading next when file ends")
    end
end

function movetofile(forward)
	local search = ' '
    for w in pairs(settings.filetypes) do
        if settings.linux_over_windows then
			search = search..string.gsub(path, "%s+", "\\ ")..settings.filetypes[w]..' '
        else
            search = search..'"'..path..settings.filetypes[w]..'" '
        end
    end

    local popen=nil
    if settings.linux_over_windows then
        popen = io.popen('find '..search..' -maxdepth 1 -type f -printf "%f\\n" 2>/dev/null | sort -f')
    else
        popen = io.popen('dir /b '..search) 
    end
    if popen then 
        local found = false
        local memory = nil
        local lastfile = true
        local firstfile = nil
        for dirx in popen:lines() do
            if found == true then
                mp.commandv("loadfile", path..dirx, "replace")
                lastfile=false
                break
            end
            if dirx == file then
                found = true
            	if not forward then
                	lastfile=false 
                	if settings.allow_looping and firstfile==nil then 
                		found=false
                	else
                		if firstfile==nil then break end
            			mp.commandv("loadfile", path..memory, "replace")
                		break
                	end
               	end
            end
            memory = dirx
        	if firstfile==nil then firstfile=dirx end
        end
        if lastfile and settings.allow_looping then
            mp.commandv("loadfile", path..firstfile, "replace")
        end
        if not found then
            mp.commandv("loadfile", path..memory, "replace")
        end

        popen:close()
    else
        msg.error("could not scan for files")
    end
end

--read settings from a script message
function loadauto(auto)
  settings.load_next_automatically = ( auto:lower() == 'true' )
end

mp.register_script_message("loadnextautomatically", loadauto)
mp.add_key_binding('SHIFT+PGDWN', 'nextfile', nexthandler)
mp.add_key_binding('SHIFT+PGUP', 'previousfile', prevhandler)
mp.add_key_binding('CTRL+N', 'autonextfiletoggle', toggleauto)
mp.register_event('file-loaded', on_loaded)
mp.register_event('end-file', on_close)
