{ config, lib, ... }:
let
  cfg = config.dragonix.features.system.nixos.base;
in
{
  options.dragonix.features.system.nixos.base.enable =
    lib.mkEnableOption "the portable Dragonix NixOS baseline";

  config = lib.mkIf cfg.enable {
    boot.tmp.cleanOnBoot = lib.mkDefault true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
