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
  name = "signal";
  description = "Public reusable desktop capability for signal.";
  packageName = "signal-desktop";
})
  moduleArgs
