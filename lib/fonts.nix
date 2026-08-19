# Shared font packages used on both macOS and NixOS hosts.
# Per-platform extras live in modules/{darwin,nixos}/fonts.nix.
pkgs: with pkgs; [
  roboto
  work-sans
  comic-neue
  inter
  lato
  (google-fonts.override { fonts = [ "Inter" ]; })
  nerd-fonts.jetbrains-mono
]
