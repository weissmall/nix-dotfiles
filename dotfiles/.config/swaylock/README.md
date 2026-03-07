## Swaylock dynamic configs

![swaylock idle demo screen](./images/swaylock-idle.jpg)
> Background was taken from [Wallheaven](https://whvn.cc/k8x15m). Image remain property of it's original owner. 

### Dependencies

Current config relies on two things:
- [Niri](https://github.com/YaLTeR/niri) as Wayland compositor
- [Waypaper](https://github.com/anufrievroman/waypaper) as wallpaper manager

### How it works

Config lists all niri outputs and takes their names like `eDP-1` or `HDMI-I-1`. After that it tries to get current wallpapers which are set up for this outputs from waypaper cli. At the end for each output script build `--image ${output}:${path}` argument and passes it to swaylock.

### Reasoning
I wanted to have simple lock with same wallpapers as on my screen. Just it. I was running [swaylock-effects](https://github.com/mortie/swaylock-effects) with screenshot feature a long time but get tired of messy screen state. More often I don't see my background because it's covered with opened programs even though I have opacity on all of them. So making this if my personal thing to have some time to enjoy wallpaper while screen is locked.

### Drawbacks
Currently it works kinda slow but I'll figure it out later if won't switch to any other lock alternative
