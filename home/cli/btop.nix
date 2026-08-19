{
  myLib,
  pkgs,
  config,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "cli.btop";
  description = "Btop system monitor";
  enableDefault = config.cli.enable or false;
  config = {
    programs.btop = {
      package = pkgs.btop-cuda;
      enable = true;
    };
    home.file.".config/btop" = {
      recursive = true;
      source = ../../config/btop;
    };
  };
}
