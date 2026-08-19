{
  myLib,
  config,
  pkgs,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "cli.herdr";
  description = "herdr with custom dotfiles symlink";
  config = {
    home.packages = with pkgs; [
      herdr
    ];

    home.file.".config/herdr".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/herdr";
  };
}
