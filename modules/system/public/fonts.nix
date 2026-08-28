{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../lib/package-feature.nix {
  namespace = [ ];
  namespaceRoot = "system";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "fonts";
  description = "Portable font configuration with a baseline font family.";
  packageName = "dejavu_fonts";
  nativeConfig = {
    fonts.fontconfig.enable = true;
  };
})
  moduleArgs
