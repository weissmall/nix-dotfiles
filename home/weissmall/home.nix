{
  config,
  pkgs,
  inputs,
  ...
}:

{

  home.username = "weissmall";
  home.homeDirectory = "/home/weissmall";
  home.stateVersion = "25.11";
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    # Env
    rofi

    # Neovim
		neovim
    fzf
    cmake
    gnumake
    rustup
    # cargo
    jsoncpp
    plantuml
    imv
    ripgrep
    gcc

    # Software
    # onlyoffice
    onlyoffice-desktopeditors
    # obsidian
    librewolf
    qbittorrent

    # Other
		git
		yadm
		ghostty
		alacritty
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
