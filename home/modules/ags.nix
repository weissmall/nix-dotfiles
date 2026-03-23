{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # symlink to ~/.config/ags
    # configDir = ../ags;

    # additional packages and executables to add to gjs's runtime
    extraPackages = with pkgs; [
      inputs.astal.packages.${pkgs.system}.apps
      inputs.astal.packages.${pkgs.system}.auth
      inputs.astal.packages.${pkgs.system}.battery
      inputs.astal.packages.${pkgs.system}.bluetooth
      inputs.astal.packages.${pkgs.system}.cava
      inputs.astal.packages.${pkgs.system}.greet
      inputs.astal.packages.${pkgs.system}.mpris
      inputs.astal.packages.${pkgs.system}.network
      inputs.astal.packages.${pkgs.system}.notifd
      inputs.astal.packages.${pkgs.system}.tray
      inputs.astal.packages.${pkgs.system}.wireplumber
      fzf
    ];
  };
}
