{ pkgs, ... }:
{
  home.packages = [
    pkgs.mongodb-compass
  ];

  xdg.desktopEntries.mongodb-compass = {
    name = "MongoDB Compass";
    exec = "mongodb-compass --password-store=\"gnome-libsecret\" --ignore-additional-command-line-flags";
    type = "Application";
  };
}
