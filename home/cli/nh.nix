{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "cli.nh";
  description = "nh Nix helper tools";
  enableDefault = config.cli.enable or false;
  config = {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--delete-older-than 0d --gc";
      };
      flake = "${config.home.homeDirectory}/dotfiles";
    };
  };
}
