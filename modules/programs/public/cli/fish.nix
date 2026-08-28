{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "cli" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "fish";
  description = "Fish shell with Home Manager-managed initialization.";
  packageName = "fish";
  nativeConfig = {
    programs.fish.enable = true;
  };
})
  moduleArgs
