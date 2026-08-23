{
  lib,
  stdenv,
  fetchurl,
  _7zz,
}:

let
  pname = "tinycast";
  version = "0.9.8";

  src = fetchurl {
    url = "https://github.com/abue-ammar/tinycast/releases/download/v${version}/Tinycast-${version}.dmg";
    sha256 = "0p89m7m2n3kf2yz57dnxn39zlhhprvjmcipsyf2vlmyylpl7w7mp";
  };
in
stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ _7zz ];

  unpackPhase = ''
    7zz x $src
  '';

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    description = "Tinycast macOS Application";
    homepage = "https://github.com/abue-ammar/tinycast";
    license = licenses.gpl3Only;
    platforms = platforms.darwin;
  };
}
