--Usage: 1. Create a internet-radio playlist in m3u format, see example playlist on github repo
--       2. Run [ mpv --idle ] and use the shortcut R to launch the radio
--          Optionally you can run [ mpv --script-opts=radiostart=true] to start without input

local settings ={
    vol = '35',                                         --radio start volume
    savepath = '/custom/radiosongs',                   --path to saved songs textfile
    playlist = "https://stream.r-a-d.io/main.mp3"     --radio playlist with your channels
}

local radio_playing = false

function volume()
    mp.command("set volume "..settings.vol)
    mp.unobserve_property(volume)
end

function radiotoggle()
    if radio_playing == false then
        mp.observe_property("volume", "number", volume)
        mp.commandv("loadfile", settings.playlist, "replace")
        radio_playing=true
    else
        mp.command("stop")
        radio_playing=false
    end
end

function radiomark()
    local songname = mp.get_property('media-title')
    if songname then
        local file = io.open(settings.savepath, "a+")
        if file then 
            file:write(songname, "\n")
            print('Saved: '..songname)
            file:close()
        else
            print("Failed to open song savepath, check permissions")
        end
    else 
        print("No songname available") 
    end
end

mp.add_key_binding('r', 'mark-song', radiomark)
mp.add_key_binding('R', 'radio-toggle', radiotoggle)

if mp.get_opt("radiostart") then
    radiotoggle()
end
