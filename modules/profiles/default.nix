{ config, lib, ... }:
let
  cfg = config.dragonix.profiles;
in
{
  options.dragonix.profiles = {
    minimal.enable = lib.mkEnableOption "the small Dragonix public baseline";

    developer.enable = lib.mkEnableOption "the Dragonix public developer profile";

    terminal.enable = lib.mkEnableOption "the Dragonix public terminal profile";
  };

  config = {
    dragonix.features.programs.cli.just.enable = lib.mkDefault (
      cfg.minimal.enable || cfg.developer.enable || cfg.terminal.enable
    );

    dragonix.features.programs.cli.essentials.enable = lib.mkDefault (
      cfg.minimal.enable || cfg.developer.enable || cfg.terminal.enable
    );

    dragonix.features.programs.cli.interactive.enable = lib.mkDefault (
      cfg.developer.enable || cfg.terminal.enable
    );

    dragonix.features.programs.cli.development.enable = lib.mkDefault cfg.developer.enable;
    dragonix.features.programs.nix.quality.enable = lib.mkDefault cfg.developer.enable;
    dragonix.features.programs.terminal.tmux.enable = lib.mkDefault (
      cfg.developer.enable || cfg.terminal.enable
    );
  };
}
