{
  myLib,
  config,
  lib,
  pkgs,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "cli.yazi";
  description = "yazi terminal file manager";
  config = {
    programs.yazi = {
      enable = true;
    };

    home.file.".config/yazi".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/yazi";
  };
}
