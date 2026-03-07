#!/bin/bash
WALL_HASH="$HOME/.config/swaylock/.waypaper.hash"
WALL_CACHE="$HOME/.config/swaylock/.wallpaper.cache"

function checkDiff() {
  # Execute waypaper --list and capture output
  output=$(waypaper --list)
  
  # Check if .waypaper.hash file exists
  if [ -f ".waypaper.hash" ]; then
      # Read the previous output from file
      previous=$(cat $WALL_HASH)
      
      # Compare current output with previous
      if [ "$output" = "$previous" ]; then
          # echo "same"
          lock >> $HOME/lock.log
      else
          # echo "different"
          echo "$output" > $WALL_HASH
          storeWallpapers
          lock >> $HOME/lock.log
      fi
  else
      # File doesn't exist, treat as different and create it
      # echo "different"
      echo "$output" > $WALL_HASH
      storeWallpapers
      lock >> $HOME/lock.log
  fi
}

function storeWallpapers() {
  # Check if .waypaper.hash exists
  if [ ! -f $WALL_HASH ]; then
      echo "Error: .waypaper.hash file not found"
      exit 1
  fi
  getImagesPerOutput > $WALL_CACHE
}

function getWallpaperByOutput() {
  output=$1
  outputsJson=$(waypaper --list | jq ".[] | select(.monitor==\"${output}\") | .wallpaper ")
  echo $outputsJson
}

function getWallpaperByOutputOrAll() {
  output=$1
  wallpaper=$(getWallpaperByOutput "${output}")
  if [[ -n $wallpaper ]]; then
    echo $wallpaper
  else
    echo $(getWallpaperByOutput "All")
  fi
}

function getImagesPerOutput() {
  niriOutputs=$(niri msg outputs | awk '/Output/ {gsub(/[()]/,"",$NF); print $NF}')
  niriOutputsArray=($niriOutputs)

  result=""
  for i in "${niriOutputsArray[@]}"; do
    wallpaper=$(getWallpaperByOutputOrAll $i)
    result+="--image $i:$wallpaper "
  done

  result=${result% }
  echo $result
}

function getCacheWallpaper() {
  echo | cat $WALL_CACHE
}

function lock() {
  
  if [[ -x '/usr/bin/swaylock' ]]; then
    swaylock \
      --daemonize\
\
      --inside-clear-color "#3E4244CC"\
      --line-clear-color "#3E4244CC"\
      --ring-clear-color "#A4C9E3CC"\
      --text-clear-color "#FFFFFF"\
\
      --inside-ver-color "#35424ACC"\
      --line-ver-color "#35424ACC"\
      --ring-ver-color "#A4C9E3CC"\
      --text-ver-color "#FFFFFF"\
\
      --inside-wrong-color "#4A3535CC"\
      --line-wrong-color "#4A3535CC"\
      --ring-wrong-color "#E3A4A4CC"\
      --text-wrong-color "#FFFFFF"\
\
      --inside-color "#3E4244CC"\
      --line-color "#3E4244CC"\
      --ring-color "#A4C9E3CC"\
      --text-color "#FFFFFF"\
\
      --text-caps-lock-color "#FFFFFF"\
\
      --key-hl-color "#FFFFFFCC"\
      --bs-hl-color "#808080CC"\
\
      --show-failed-attempts\
      --fade-in 0.2\
      --effect-blur 2x1\
      --effect-vignette 0.5:0.5\
      --ignore-empty-password\
      $(getCacheWallpaper) \
      --clock \
      --grace 1\
      -e
  fi
}


# lock >> $HOME/lock.log
checkDiff
