{
  config,
  pkgs,
  inputs,
  ...
}:

{

  home.stateVersion = "25.11";
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    librewolf
    ripgrep
    fzf
    cmake
    gnumake
    gcc
    rofi
  ];

  imports = [
    ./dotfiles.nix
    ../modules/zsh.nix
  ];

  # home.file.".config/zsh" = {
  #   source = "${inputs.zsh-dotfiles}";
  #   recursive = true;
  # };
  #
  # programs.zsh = {
  #   enable = true;
  #   initExtra = ''
  #     source ~/.config/zsh/rc.zsh
  #   '';
  # };
}
