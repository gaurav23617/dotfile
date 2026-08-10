{
  lib,
  stdenv,
  fetchurl,
}:

let
  pname = "multica-cli";
  version = "0.3.25";

  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/kiyors/multica/releases/download/v${version}/multica-cli-${version}-darwin-arm64.tar.gz";
      sha256 = "06bhjhl8y4ly3368ifll1ma5dsnszkhwafdk0f0mjxi1ib6860hh";
    };
    "x86_64-darwin" = {
      url = "https://github.com/kiyors/multica/releases/download/v${version}/multica-cli-${version}-darwin-amd64.tar.gz";
      sha256 = "0fwqhv81ymp0nzvb0zb8m5c2iqbp0zznlnx7wl38n0dy5rmkbp1l";
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
    cp multica $out/bin/
    chmod +x $out/bin/multica
  '';

  meta = with lib; {
    description = "Multica CLI Application";
    homepage = "https://github.com/kiyors/multica";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
