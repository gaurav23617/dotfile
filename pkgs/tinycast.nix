{
  lib,
  stdenv,
  fetchurl,
  _7zz,
}:

let
  pname = "tinycast";
  version = "0.10.20";

  src = fetchurl {
    url = "https://github.com/abue-ammar/tinycast/releases/download/v${version}/Tinycast-${version}.dmg";
    sha256 = "a0003d9b1566568a76b1fcb553914ff1ae328af6398cc177e26a6177199cf3fc";
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
        mkdir -p $out/Applications $out/bin
        cp -r *.app $out/Applications

        cat << 'EOF' > $out/bin/tinycast
    #!/usr/bin/env bash
    case "$1" in
      restart)
        pkill -x "Tinycast" 2>/dev/null || true
        sleep 0.5
        open -g -a Tinycast
        ;;
      kill)
        pkill -x "Tinycast"
        ;;
      *)
        open -a Tinycast "$@"
        ;;
    esac
    EOF
        chmod +x $out/bin/tinycast
  '';

  meta = with lib; {
    description = "Tinycast macOS Application";
    homepage = "https://github.com/abue-ammar/tinycast";
    license = licenses.gpl3Only;
    platforms = platforms.darwin;
  };
}
