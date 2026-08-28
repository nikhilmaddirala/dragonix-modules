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
  name = "helix";
  description = "Helix editor with portable editing defaults.";
  packageName = "helix";
  nativeConfig = {
    programs.helix = {
      enable = true;
      settings = {
        editor = {
          cursorline = true;
          line-number = "relative";
          true-color = true;
          indent-guides.render = true;
        };
      };
    };
  };
})
  moduleArgs
