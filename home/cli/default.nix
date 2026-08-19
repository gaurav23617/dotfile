{
  myLib,
  config,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "cli";
  description = "CLI tools ecosystem";
  config = { };
  imports = [
    ./bat.nix
    ./btop.nix
    ./eza.nix
    ./fastfetch.nix
    ./nh.nix
    ./yazi.nix
    ./tmux.nix
    ./lazydocker.nix
    ./herdr.nix
  ];
}
