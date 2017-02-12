--Author: donmaiq
--Appends url from clipboard to the playlist
--Requires xclip

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  return s
end

function append()
	local url = os.capture('xclip -o -selection clipboard')
	mp.commandv("loadfile", url, "append-play")
	mp.osd_message("URL loaded to playlist")
end

mp.add_key_binding("a", "appendURL", append)
