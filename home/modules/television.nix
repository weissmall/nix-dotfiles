{ pkgs, ... }:
{

  home.packages = with pkgs; [
    jq
    television
  ];
}
