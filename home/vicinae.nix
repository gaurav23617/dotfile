{
  myLib,
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
myLib.mkHomeModule {
  globalConfig = config;
  name = "desktop.vicinae";
  description = "Vicinae launcher and clipboard manager";
  imports = [ inputs.vicinae.homeManagerModules.default ];
  config = {
    programs.vicinae = {
      enable = true;
      systemd = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
        enable = true;
        autoStart = true;
      };
      settings = {
        close_on_focus_loss = true;
        consider_preedit = true;
        pop_to_root_on_close = true;
        favicon_service = "twenty";
        search_files_in_root = true;
        providers = {
          applications = {
            enabled = true;
          };
        };
        font = {
          normal = {
            size = 12;
            family = "Maple Mono";
          };
        };
        theme = {
          light = {
            name = "vicinae-light";
            icon_theme = "default";
          };
          dark = {
            name = "vicinae-dark";
            icon_theme = "default";
          };
        };
        launcher_window = {
          opacity = 0.98;
        };
      };
      extensions =
        let
          exts = inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system};
        in
        [ exts.nix ]
        ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux (
          map (name: exts.${name}) (
            lib.filter (name: exts ? ${name}) [
              "power-profile"
              "wifi-commander"
            ]
          )
        );
    };
    systemd.user.services.vicinae.Service.Environment = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      USE_LAYER_SHELL = "1";
      XDG_DATA_DIRS = "${config.home.homeDirectory}/.nix-profile/share:/etc/profiles/per-user/${config.home.username}/share:/run/current-system/sw/share:/usr/share:${config.home.homeDirectory}/.local/share";
      PATH = "${lib.makeBinPath [ pkgs.pulseaudio ]}:${
        inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default
      }/libexec/vicinae:${config.home.homeDirectory}/.nix-profile/bin:/etc/profiles/per-user/${config.home.username}/bin:/run/current-system/sw/bin:/run/wrappers/bin";
    };
    home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [ pkgs.pulseaudio ];
  };
}
