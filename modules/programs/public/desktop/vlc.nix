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
  name = "vlc";
  description = "Public reusable desktop capability for vlc.";
  packageName = "vlc";
})
  moduleArgs
