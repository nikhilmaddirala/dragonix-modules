{
  config,
  lib,
  pkgs,
  ...
}@moduleArgs:
(import ../../../lib/package-feature.nix {
  namespace = [ "ide" ];
  namespaceRoot = "programs";
  optionRoot = [
    "dragonix"
    "public"
    "features"
  ];
  name = "editor-formatters";
  description = "Public reusable ide capability for editor-formatters.";
  packageName = "nixfmt-rfc-style";
})
  moduleArgs
