{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "terminal" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "rxvt-unicode";
  description = "Public reusable terminal capability for rxvt-unicode.";
  packageName = "rxvt-unicode";
})
  moduleArgs
