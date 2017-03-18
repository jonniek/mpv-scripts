A collection of all my scripts. Small ones are in this repo and bigger ones are linked to.  
  
What are lua scripts? [Mpv.io lua documentation](https://mpv.io/manual/master/#lua-scripting)  
Where should I put them? [Unix](https://mpv.io/manual/stable/#files) [Windows](https://mpv.io/manual/stable/#files-on-windows)  
How do I use them? Use default keybinds or bind your own in [input.conf](https://mpv.io/manual/stable/#input-conf). Some of my scripts require you to edit some settings in the head of lua files to work.


##Small scripts inside this repo
Script tags below are keybindings you can add to input.conf  
###[appendUrl.lua](https://github.com/donmaiq/mpv-scripts/blob/master/appendURL.lua)  
  Appends url from clipboard to playlist.  
  `a script-binding appendURL`  
###[cycleaudiodevice.lua](https://github.com/donmaiq/mpv-scripts/blob/master/cycleaudiodevice.lua)  
  Cycles predefined audio devices. Created this because updating device name on many places was not convenient. Now I can just call script message with headphones/speakers from different places like for example [context](https://gist.github.com/avih/bee746200b5712220b8bd2f230e535de) menu script and only change them in one place between systems/setups. Set devices to match your system before using with help of `mpv --audio-device=help`. If you toggle only with key consider using a simple input config like `ctrl+A cycle-values audio-device "auto" "openal/device1" "pulse/device2.analog-stereo"` instead of this script.  
  `ctrl+A script-binding cycleaudiodevice`  
  argument below is index or nicename of device  
  `KEY script-message setaudiodevice argument` - set audio device on runtime  
  `--script-opts=audio=argument` - set audio device on startup  
###[radio.lua](https://github.com/donmaiq/mpv-scripts/blob/master/radio.lua)  
  Loads a radio playlist/file on keybind with ability to save song names into a file.  
  `R script-binding radio-toggle`  
  `r script-binding mark-song`  
###[trashfileonend.lua](https://github.com/donmaiq/mpv-scripts/blob/master/trashfileonend.lua)  
  Allows you to remove one or more files after they have ended playing. Settings for different eof-reasons and default behaviour are inside lua settings variable. Use with toggling keybind or send command directly with script message.  
  `ctrl+alt+x script-binding toggledeletefile`  
  `KEY script-message trashfileonend true true` - deletefile[true, false], oneonly[true, false]  
  
##My bigger scripts
###[unseen-playlistmaker](https://github.com/donmaiq/unseen-playlistmaker)
  Keeps track of your watched files locally and loads unseen files from a specified directory into a playlist on keybind.  
###[playlistmanager](https://github.com/donmaiq/Mpv-Playlistmanager)
  Show playlist in a readable, navigatable and editable format as an osd_message. Cool quirks like filename formatting, saving, loading, shuffling sorting and more included.
###[Filenavigator](https://github.com/donmaiq/mpv-filenavigator)
  Navigate your local system and open directories or files, or add files to your playlist. Linux/MacOS only.
###[waifu2x](https://github.com/donmaiq/mpv-waifu2x)  
  Take screenshots or convert images with waifu2x upscalling algorithm.
###[nextfile](https://github.com/donmaiq/mpv-nextfile)  
  Force open next or previous file in the currently playing files directory.  
  &nbsp;  
---
>Permission to use, copy, modify, and/or distribute all of this software for any purpose with or without fee is hereby granted  

>All of the software is provided as is and the author disclaims all warranties with regard to this software including all implied warranties of merchantability and fitness. In no event shall the author be liable for any special, direct, indirect, or consequential damages or any damages whatsoever resulting from loss of use, data or profits, whether in an action of contract, negligence or other tortious action, arising out of or in connection with the use or performance of this software.
