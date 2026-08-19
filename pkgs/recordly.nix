{
  lib,
  stdenv,
  fetchurl,
  undmg,
}:

let
  pname = "recordly";
  version = "1.3.3";

  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/webadderallorg/Recordly/releases/download/v${version}/Recordly-arm64.dmg";
      sha256 = "1rfypfv6idbj7vnbbdr3a2a4qdmg42nx4dmvg3yl03c7dq8z9a3z";
    };
    "x86_64-darwin" = {
      url = "https://github.com/webadderallorg/Recordly/releases/download/v${version}/Recordly-x64.dmg";
      sha256 = "119zjb9bsv75qh3vxjbvwjrbqz189a1rmj9gn5qsgg5gyw5rmr1m";
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
    description = "Recordly - Create polished demo videos without editing skills";
    homepage = "https://github.com/webadderallorg/Recordly";
    license = licenses.agpl3Only;
    platforms = platforms.darwin;
  };
}
