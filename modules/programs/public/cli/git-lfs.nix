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
  name = "git-lfs";
  description = "Public reusable cli capability for git-lfs.";
  packageName = "git-lfs";
})
  moduleArgs
