{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../lib/package-feature.nix {
  namespace = [ ];
  namespaceRoot = "system";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "hyprland";
  description = "Public reusable system capability for hyprland.";
  packageName = "hyprland";
})
  moduleArgs
