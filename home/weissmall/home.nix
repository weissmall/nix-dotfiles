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
    jsoncpp
    plantuml
    imv
    ripgrep
    gcc

    # Software
    onlyoffice-desktopeditors
    # obsidian
    librewolf
    qbittorrent

    # Other
		git
		yadm
		ghostty
		alacritty

    # Fonts
    font-awesome
    noto-fonts
    material-design-icons
    nerd-fonts.jetbrains-mono
    dejavu_fonts
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
  fonts.fontconfig.enable = true;
}
