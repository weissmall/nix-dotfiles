{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
    };
  };
}
