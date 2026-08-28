{ config, lib, ... }:
let
  cfg = config.dragonix.features.system.darwin.desktop;
in
{
  options.dragonix.features.system.darwin.desktop.enable =
    lib.mkEnableOption "portable Darwin desktop defaults";

  config = lib.mkIf cfg.enable {
    system.defaults.NSGlobalDomain.AppleInterfaceStyle = lib.mkDefault "Dark";
  };
}
