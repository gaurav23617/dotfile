{
  lib,
  stdenv,
  fetchurl,
  undmg,
}:

let
  pname = "multica";
  version = "0.3.25";

  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/kiyors/multica/releases/download/v${version}/multica-desktop-${version}-mac-arm64.dmg";
      sha256 = "1qfz7074vwj4rwra9ff8vxz3p680pacrjm5z7x7zm76prn24cwxj";
    };
    "x86_64-darwin" = {
      url = "https://github.com/kiyors/multica/releases/download/v${version}/multica-desktop-${version}-mac-x64.dmg";
      sha256 = "0kfg5f4klywykbkddyw6alhqkcbpc6n1v08f8v23292hikylv0hj";
    };
  };

  src = fetchurl {
    inherit (sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}")) url sha256;
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    description = "Multica Desktop Application";
    homepage = "https://github.com/kiyors/multica";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
