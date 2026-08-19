{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../../home
  ];

  versionControl.git.enable = true;
  cli.enable = true;
  cli.lazydocker.enable = true;
  cli.yazi.enable = true;
  shell.tools.enable = true;

  home.username = "gaurav";
  home.homeDirectory = "/home/gaurav";

  home.packages = [ ];
  home.file = { };

  # Disable XDG for initial install
  xdg.userDirs.enable = false;

  programs.home-manager.enable = true;
  home.stateVersion = "26.11";
}
