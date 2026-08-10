{
  lib,
  stdenv,
  fetchurl,
}:

let
  pname = "moviebox-tui";
  version = "0.1.10";

  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/mesamirh/MovieBox-Tui/releases/download/v${version}/MovieBox_macOS_Universal.tar.gz";
      sha256 = "d78279b3034d4c7fca49babb7834ce88497cc53f032c66f436ea20029ef6fa1f";
    };
    "x86_64-darwin" = {
      url = "https://github.com/mesamirh/MovieBox-Tui/releases/download/v${version}/MovieBox_macOS_Universal.tar.gz";
      sha256 = "d78279b3034d4c7fca49babb7834ce88497cc53f032c66f436ea20029ef6fa1f";
    };
    "aarch64-linux" = {
      url = "https://github.com/mesamirh/MovieBox-Tui/releases/download/v${version}/MovieBox_Linux_arm64.tar.gz";
      sha256 = "89d713037e02245cb9cc295a2702027bd413701781ecdc566c6c6779ac2f3764";
    };
    "x86_64-linux" = {
      url = "https://github.com/mesamirh/MovieBox-Tui/releases/download/v${version}/MovieBox_Linux_x64.tar.gz";
      sha256 = "1192ff4a8b5d0475fe3d5a8c6016543e3f00bf432eb41d244287dd66fc6a6d47";
    };
  };

  src = fetchurl {
    inherit (sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}")) url sha256;
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp moviebox-tui $out/bin/
    chmod +x $out/bin/moviebox-tui
  '';

  meta = with lib; {
    description = "MovieBox-TUI - A terminal user interface for MovieBox";
    homepage = "https://github.com/mesamirh/MovieBox-TUI";
    license = licenses.mit;
    platforms = [ "x86_64-darwin" "aarch64-darwin" "x86_64-linux" "aarch64-linux" ];
  };
}
