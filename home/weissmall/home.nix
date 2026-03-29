{
  config,
  pkgs,
  inputs,
  ...
}:

{

  nixpkgs.config.allowUnfree = true;
  home.username = "weissmall";
  home.homeDirectory = "/home/weissmall";
  home.stateVersion = "25.11";
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.packages = with pkgs; [
    # Shell
    eza
    btop
    tmux
    zellij
    openssl
    git-filter-repo

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
    inputs.nil.packages.${pkgs.system}.default

    # Software
    onlyoffice-desktopeditors
    telegram-desktop
    mongodb-compass
    # beekeeper-studio

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
    kanshi
    fluffychat
    code-cursor
    networkmanagerapplet
    cliphist
    freelens-bin
    opencode
    kubectl
    obsidian
    jq

    podman
    podman-compose
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    seahorse
  ];

  imports = [
    # ../modules/zsh.nix
    ../modules/ags.nix
    ../modules/zellij.nix
    ../modules/environment.nix
    ../modules/television.nix
    # ../modules/noctalia.nix
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

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
