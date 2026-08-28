{ config, lib, ... }:
let
  cfg = config.dragonix.features.system.nixos.desktop;
in
{
  options.dragonix.features.system.nixos.desktop.enable =
    lib.mkEnableOption "portable NixOS desktop defaults";

  config = lib.mkIf cfg.enable {
    services.dbus.enable = true;
    security.rtkit.enable = lib.mkDefault true;
  };
}
