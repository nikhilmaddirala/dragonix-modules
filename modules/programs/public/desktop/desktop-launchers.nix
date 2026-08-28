{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "desktop" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "desktop-launchers";
  description = "Public reusable desktop capability for desktop-launchers.";
  packageName = "rofi";
})
  moduleArgs
