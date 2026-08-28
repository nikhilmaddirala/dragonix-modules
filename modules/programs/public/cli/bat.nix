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
  name = "bat";
  description = "Syntax-highlighted file viewing with a portable bat configuration.";
  packageName = "bat";
  nativeConfig = {
    programs.bat = {
      enable = true;
      config = {
        style = "numbers,changes,header";
        pager = "less -FR";
      };
    };
  };
})
  moduleArgs
