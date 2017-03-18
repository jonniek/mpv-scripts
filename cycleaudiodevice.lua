--find devices with 'mpv --audio-device=help'
--set audio device on startup with --script-opts=audio=nicename
--or set on runtime with --script-message setaudiodevice nicename
mp.set_property("audio-fallback-to-null", "yes")
local index = 1
local devices = {
  { ['name'] = 'auto', ['nicename'] = 'default' },
  { ['name'] = 'openal/Built-in Audio Analog Stereo', ['nicename'] = 'headphones' },
  { ['name'] = 'pulse/alsa_output.pci-0000_06_00.0.analog-stereo', ['nicename'] = 'speaker' },
}

function setdevice()
  mp.set_property("audio-device", devices[index]['name'])
  mp.osd_message("Audio device set: "..devices[index]['nicename'])
end

function setdevicebymessage(message)
  if message then
    local match = false
    for deviceindex in ipairs(devices) do
      if devices[deviceindex]['nicename']:lower() == message:lower() then
        index = deviceindex
        match = true
        break
      end
    end
    if not match then index = tonumber(message) end
    setdevice()
  end
end

deviceonstart = mp.get_opt("audio")
if deviceonstart then
    setdevicebymessage(deviceonstart)
end

mp.register_script_message("setaudiodevice", setdevicebymessage)
mp.add_key_binding("ctrl+A", "cycleaudiodevice", function()
  if not #devices or not devices then return end
  if #devices ~= index then
    index = index + 1
    setdevice()
  else
    index = 1
    setdevice()
  end
end) 
