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
  name = "mpv";
  description = "Public reusable desktop capability for mpv.";
  packageName = "mpv";
})
  moduleArgs
