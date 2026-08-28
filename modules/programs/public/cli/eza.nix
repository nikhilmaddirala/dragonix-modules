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
  name = "eza";
  description = "Directory listings with Git-aware eza defaults.";
  packageName = "eza";
  nativeConfig = {
    programs.eza = {
      enable = true;
      extraOptions = [ "--git" ];
    };
  };
})
  moduleArgs
