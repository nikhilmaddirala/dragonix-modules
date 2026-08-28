{ config, lib, ... }:
let
  cfg = config.dragonix.features.system.darwin.base;
in
{
  options.dragonix.features.system.darwin.base.enable =
    lib.mkEnableOption "the portable Dragonix Darwin baseline";

  config = lib.mkIf cfg.enable {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
