{ ... }:
{
  programs.neovim = {
    enable = true;
    extraPackages =
      let
        tools =
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
        languageServers =
          epkgs: with epkgs; [
            lua-language-server
            terraform-ls
            docker-language-server
            gopls
          ];
        packages = tools ++ languageServers;
      in
      packages;
  };
}
