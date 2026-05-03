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
      vpn = {
        plugins = "l2tp";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    xl2tpd
    ppp
    iproute2
    strongswan
  ];

  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };

  security.polkit.enable = true;

  services.dbus = {
    enable = true;
    packages = [
      pkgs.gnome-keyring
      pkgs.gcr
      pkgs.networkmanager-l2tp
    ];
  };
}
