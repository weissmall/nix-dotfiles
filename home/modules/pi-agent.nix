{
  pkgs,
  ...
}:

let
  pi = pkgs.stdenv.mkDerivation {
    pname = "pi-coding-agent";
    version = "0.74.2";

    src = pkgs.fetchurl {
      url = "https://github.com/earendil-works/pi/releases/download/v0.74.2/pi-linux-x64.tar.gz";
      hash = "sha256-cnz6hNpO8MXoindN725DZK2RSn/y/pjRCt6yJwo9U3U=";
    };

    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.makeWrapper
    ];

    installPhase = ''
      mkdir -p $out/lib/pi

      cp -r . $out/lib/pi

      chmod +x $out/lib/pi/pi

      makeWrapper $out/lib/pi/pi $out/bin/pi \
        --chdir $out/lib/pi
    '';
  };
in
{
  home.packages = [ pi ];
}
