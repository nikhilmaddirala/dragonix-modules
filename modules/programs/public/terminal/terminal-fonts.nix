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
  name = "terminal-fonts";
  description = "Public reusable terminal capability for terminal-fonts.";
  packageName = "dejavu_fonts";
})
  moduleArgs
