{ ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages =
      epkgs: with epkgs; [
        rustup
        cmake
        fzf
        gnumake
        jsoncpp
        plantuml
        imv
        ripgrep
        gcc
      ];
  };
}
