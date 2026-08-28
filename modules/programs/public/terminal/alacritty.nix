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
  name = "alacritty";
  description = "Public reusable terminal capability for alacritty.";
  packageName = "alacritty";
})
  moduleArgs
