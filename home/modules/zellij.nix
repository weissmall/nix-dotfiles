{ pkgs, ... } : {
  home.packages = with pkgs; [
    zellij
    fd
    bat
  ];
}
