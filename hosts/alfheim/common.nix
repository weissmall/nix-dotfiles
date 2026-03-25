{ pkgs, inputs, ... }: {
  # System packages
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    qt6.qtwayland
    git
    inputs.home-manager.packages.x86_64-linux.default
    # Steam
    steam
    vulkan-loader
    vulkan-tools
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # niri
  programs.niri.enable = true;

  security.polkit.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # zsh
  programs.zsh.enable = true;

  # Enable dynamic linking
  programs.nix-ld.enable = true;

  # Display manager to login
  # LY
  services.displayManager.ly.enable = true;
  services.displayManager.ly.x11Support = true;
  services.displayManager.ly.settings = {
    animation = "matrix";
    animate = false;
    clock = true;
    load = false;
  };

  # Steam
  programs.steam = {
    enable = true;
  };

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };

  virtualisation.docker.enable = true;
}
