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
    # Shell
    eza

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
    telegram-desktop

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

    # Other
    swww
    waypaper
    wl-clipboard
    zoxide
    swaylock-effects
    starship
  ];

  imports = [
    # ../modules/zsh.nix
    ../modules/ags.nix
  ];

  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "weissmall";
        email = "dany.weissmall@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };

  fonts.fontconfig.enable = true;
}
