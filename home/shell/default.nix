{
  myLib,
  lib,
  config,
  ...
}:
{
  imports = [
    ./nushell.nix
    ./zsh.nix

    ./tools/atuin.nix
    ./tools/direnv.nix
    ./tools/starship.nix
  ];
}
// myLib.mkHomeModule {
  globalConfig = config;
  name = "shell.tools";
  description = "Shell tools ecosystem";
  config = { }; # No actual config payload here, it just defines the option for the submodules to reference.
}
