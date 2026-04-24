{ pkgs, ... }:
{
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-ssh
      networkmanager-l2tp
    ];
    settings = {
      main = {
        plugins = "keyfile";
      };
    };
  };
  services.strongswan.enable = true;
  # services.gnome.gnome-keyring = {
  #   enable = true;
  # };
  # systemd.user.services.gnome-keyring = {
  #   wantedBy = [ "default.target" ];
  # };

  security.polkit.enable = true;
  # programs.nm-applet.enable = true;

  services.dbus = {
    enable = true;
    packages = [
      pkgs.gnome-keyring
      pkgs.gcr
    ];
  };
}
