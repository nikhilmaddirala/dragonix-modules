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
  name = "ncdu";
  description = "Public reusable cli capability for ncdu.";
  packageName = "ncdu";
})
  moduleArgs
