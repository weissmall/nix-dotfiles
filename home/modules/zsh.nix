{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # shell = pkgs.zsh;

  home.packages = with pkgs; [
    zsh
    starship
    eza
  ];

  home.file.".config/zsh" = {
    source = "${inputs.zsh-dotfiles}";
    recursive = true;
  };

  programs.zsh = {
    enable = true;
    initContent = "export ZSHRC_DOTS_HOME=\${HOME}/.config/zsh\nsource ~/.config/zsh/rc.zsh\neval \"$(starship init zsh)\"\n";
  };

}
