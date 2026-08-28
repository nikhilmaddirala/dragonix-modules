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
  name = "zsh";
  description = "Z shell with Home Manager-managed initialization.";
  packageName = "zsh";
  nativeConfig = {
    programs.zsh.enable = true;
  };
})
  moduleArgs
