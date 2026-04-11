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
  services.gnome.gnome-keyring.enable = true;
}
