#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

dir="$HOME/.config/rofi/"
theme='launcher'

## Run
# rofi \
#     -show drun \
#     -theme ${dir}/${theme}.rasi

function showDrun()
{
  rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
}


function showRun()
{
  rofi \
    -show run \
    -theme ${dir}/${theme}.rasi
}

function showWindow()
{
  rofi \
    -show window \
    -theme ${dir}/${theme}.rasi
}

function showSsh()
{
  rofi \
    -show ssh \
    -terminal wezterm \
    -theme ${dir}/${theme}.rasi
}

function showEmoji() {
  rofi \
    -modi emoji \
    -show emoji \
    -emoji-format '{emoji} {name}' \
    -theme ${dir}/${theme}.rasi
}

function showCursorRun() {
  path=$(getZoxidePath)
  runCursor $path
}

function getZoxidePath() {
  echo $(zoxide query --list | rofi \
    -dmenu \
    -case-smart \
    -theme ${dir}/${theme}.rasi)
}

function runCursor() {
  if [[ -n $1 ]]; then
    cursor $1
  fi
}

"$@"
