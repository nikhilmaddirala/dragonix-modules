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
  name = "flatpak";
  description = "Public reusable system capability for flatpak.";
  packageName = "flatpak";
})
  moduleArgs
