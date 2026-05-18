{ pkgs, ... }:
let
  cursorName = "catppuccin-latte-light-cursors";
  cursorPackage = pkgs.catppuccin-cursors.latteLight;
  cursorSize = 14;
in
{
  home = {
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;

      package = cursorPackage;
      name = cursorName;
      size = cursorSize;
    };

    sessionVariables = {
      XCURSOR_THEME = cursorName;
      XCURSOR_SIZE = toString cursorSize;
    };
  };
}
