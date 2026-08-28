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
  supportedSystems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
})
  moduleArgs
