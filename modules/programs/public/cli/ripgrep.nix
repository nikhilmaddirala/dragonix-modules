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
  name = "ripgrep";
  description = "Public reusable cli capability for ripgrep.";
  packageName = "ripgrep";
})
  moduleArgs
