A collection of all my scripts. Small ones are in this repo and bigger ones are linked to.
##Small scripts inside this repo
Script tags below are keybindings you can add to input.conf  
###[appendUrl](https://github.com/donmaiq/mpv-scripts/blob/master/appendURL.lua)
  Appends url from clipboard to playlist. Requires xclip.  
  `a script-binding appendURL`  
###[cycleaudiodevice](https://github.com/donmaiq/mpv-scripts/blob/master/cycleaudiodevice.lua)
  Cycles predefined audio devices.  
  `ctrl+A script-binding cycleaudiodevice`  
  `KEY script-message setaudiodevice argument` - argument is index or nicename of device  
###[radio](https://github.com/donmaiq/mpv-scripts/blob/master/radio.lua)
  Loads a radio playlist/file on keybind with ability to save song names into a file.  
  `R script-binding radio-toggle`  
  `r script-binding mark-song`  
###[trashfileonend](https://github.com/donmaiq/mpv-scripts/blob/master/trashfileonend.lua)
  Allows you to remove one or more files after they have ended playing. Settings for different eof-reasons and default behaviour are inside lua settings variable. Use with toggling keybind or send command directly with script message.  
  `ctrl+alt+x script-binding toggledeletefile`  
  `alt+x script-message trashfileonend true true` - deletefile[true, false], oneonly[true, false]  
  
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
   
