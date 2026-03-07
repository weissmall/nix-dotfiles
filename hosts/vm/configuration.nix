# {
#   config,
#   pkgs,
#   inputs,
#   ...
# }:
# {
#   imports = [
#     ./hardware-configuration.nix
#   ];
#
#   networking.hostName = "bibaboba";
#   networking.networkManager.enable = true;
#
#   nix.settings.experimental-features = [
#     "nix-command"
#     "flakes"
#   ];
#
#   environment.systemPackages = [
#     pkgs.git
#     pkgs.neovim
#   ];
#
#   system.stateVersion = "24.05";
# }

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./weiss.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "bibaboba"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Minsk";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.weissmall = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "weissmall";
    extraGroups = [ "networkmanager" "wheel" "vboxguest" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  # ];

  environment.systemPackages = with pkgs; [
		git
		yadm
		ghostty
		alacritty
		fuzzel
		neovim
		xwayland-satellite
		qt6.qtwayland
    cargo
		mesa-demos
		mesa
		linuxPackages.virtualboxGuestAdditions
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?


  # VM Specific
	virtualisation.virtualbox.guest = {
		enable = true;
		# x11 = true;
	};

	services.xserver.videoDrivers = ["virtualbox"];

	# hardware.graphics.enable = true;
	# hardware.graphics.enable32Bit = true;

  # LY
  services.displayManager.ly.enable = true;
  services.displayManager.ly.x11Support = true;
  services.displayManager.ly.settings = {
    animation = "matrix";
    animate = false;
    clock = true;
    load = false;
  };

  # niri
  programs.niri.enable = true;
  programs.zsh.enable = true;
  security.polkit.enable = true;
	nix.settings.experimental-features = ["nix-command" "flakes"];
}
