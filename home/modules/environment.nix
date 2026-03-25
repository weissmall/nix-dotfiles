{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    helvum
  ];
}
