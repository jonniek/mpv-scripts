--Author: donmaiq
--Appends url from clipboard to the playlist
--Requires xclip

--detect_platform() and get_clipboard() copied and edited from:
--https://github.com/rossy/mpv-repl
--repl.lua -- A graphical REPL for mpv input commands
--
-- © 2016, James Ross-Gowan
--
-- Permission to use, copy, modify, and/or distribute this software for any
-- purpose with or without fee is hereby granted, provided that the above
-- copyright notice and this permission notice appear in all copies.

local utils = require 'mp.utils'
local msg = require 'mp.msg'

function append(primaryselect)
  local clipboard = get_clipboard(primaryselect or true)
  if clipboard then
    mp.commandv("loadfile", clipboard, "append-play")
    mp.osd_message("URL appended: "..clipboard)
    msg.info("URL appended: "..clipboard)
    retried = false
  end
end

function detect_platform()
  local o = {}
  if mp.get_property_native('options/vo-mmcss-profile', o) ~= o then
    return 'windows'
  elseif mp.get_property_native('options/input-app-events', o) ~= o then
    return 'macos'
  end
  return 'linux'
end
local platform = detect_platform()

local retried = false
function handleres(res, args)
  if not res.error and res.status == 0 then
      return res.stdout
  else
    --if clipboard failed try primary selection
    if platform=='linux' and not retried then 
      retried = true
      append(false)
      return nil
    end
    if res.error == nil then res.error = "" end
    msg.error("There was an error getting "..platform.." clipboard: ")
    msg.error("  Status: "..res.status)
    msg.error("  Error: "..res.error)
    msg.error("  stdout: "..res.stdout)
    msg.error("args: "..utils.to_string(args))
    return nil
  end
end

function get_clipboard(clip) 
  if platform == 'linux' then
    local args = { 'xclip', '-selection', clip and 'clipboard' or 'primary', '-out' }
    return handleres(utils.subprocess({ args = args }), args)
  elseif platform == 'windows' then
    local args = {
      'powershell', '-NoProfile', '-Command', [[& {
        Trap {
          Write-Error -ErrorRecord $_
          Exit 1
        }

        $clip = ""
        if (Get-Command "Get-Clipboard" -errorAction SilentlyContinue) {
          $clip = Get-Clipboard -Raw -Format Text -TextFormatType UnicodeText
        } else {
          Add-Type -AssemblyName PresentationCore
          $clip = [Windows.Clipboard]::GetText()
        }

        $clip = $clip -Replace "`r",""
        $u8clip = [System.Text.Encoding]::UTF8.GetBytes($clip)
        [Console]::OpenStandardOutput().Write($u8clip, 0, $u8clip.Length)
      }]]
    }
    return handleres(utils.subprocess({ args =  args }), args)
  elseif platform == 'macos' then
    local args = { 'pbpaste' }
    return handleres(utils.subprocess({ args = args }), args)
  end
  return nil
end

mp.add_key_binding("a", "appendURL", append)
