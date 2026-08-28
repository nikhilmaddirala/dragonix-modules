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
  name = "fzf";
  description = "Fuzzy command-line selection with Home Manager integration.";
  packageName = "fzf";
  nativeConfig =
    { lib, options, ... }:
    {
      programs.fzf.enable = true;
    }
    // (
      if lib.hasAttrByPath [ "programs" "fzf" "historyWidget" ] options then
        {
          # Atuin owns Ctrl-R when both public history integrations are enabled.
          programs.fzf.historyWidget.command = "";
        }
      else if lib.hasAttrByPath [ "programs" "fzf" "historyWidgetCommand" ] options then
        {
          # Compatibility with older Home Manager option names.
          programs.fzf.historyWidgetCommand = "";
        }
      else
        { }
    );
})
  moduleArgs
