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
  name = "thunderbird";
  description = "Public reusable desktop capability for thunderbird.";
  packageName = "thunderbird";
})
  moduleArgs
