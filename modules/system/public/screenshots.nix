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
  name = "screenshots";
  description = "Public reusable system capability for screenshots.";
  packageName = "grim";
  supportedSystems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
})
  moduleArgs
