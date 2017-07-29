--[[
1. Create a internet-radio playlist in m3u format
2. Run [ mpv --idle ] and use the shortcut R to launch the radio
   Optionally you can run [ mpv --no-video --idle=once --script-opts=radio-autostart=yes ] to open on startup
   note: volume in http profile will override this script volume
]]--

local settings = {
    autostart = false, --setting to start on mpv start, requires --idle=once or --idle=yes
    vol = 70, --radio start volume
    savepath = "/home/anon/radiosongs", --path to saved songs file
    playlist = "/home/anon/radio.m3u" --radio playlist with your channels
}

require 'mp.options'
read_options(settings, "radio")
local msg = require 'mp.msg'

local radio_playing = false

function radiotoggle()
  if radio_playing == false then
    mp.commandv("loadfile", settings.playlist, "replace")
    mp.set_property("volume", settings.vol)
    radio_playing=true
  else
    mp.command("stop")
    radio_playing=false
  end
end

function radiomark()
  if not radio_playing then return end
  local songname = mp.get_property('media-title')
  local filename = mp.get_property('filename')
  if songname ~= filename then
    local file = io.open(settings.savepath, "a+")
    if file then 
      file:write(songname, "\n")
      msg.info('Saved: '..songname)
      file:close()
    else
      msg.error("Failed to open savepath, check path and permissions")
    end
  else
    msg.error("No title available") 
  end
end

mp.add_key_binding('r', 'mark-song', radiomark)
mp.add_key_binding('R', 'radio-toggle', radiotoggle)

if settings.autostart then
  radiotoggle()
end
