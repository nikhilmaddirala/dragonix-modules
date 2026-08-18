{ config, lib, ... }:
let
  cfg = config.dragonix.features.programs.cli.interactive;
in
{
  options.dragonix.features.programs.cli.interactive = {
    enable = lib.mkEnableOption "interactive shell conveniences";

    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        cat = "bat";
        la = "eza -la";
        ll = "eza -lah --git";
      };
      description = "Shell aliases installed by the interactive CLI feature.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.shellAliases = cfg.aliases;

    programs = {
      bat.enable = true;
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      eza.enable = true;
      fzf.enable = true;
      starship.enable = true;
      tealdeer.enable = true;
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
