{ config, lib, ... }:
let
  cfg = config.dragonix.features.programs.terminal.wezterm;
in
{
  options.dragonix.features.programs.terminal.wezterm = {
    enable = lib.mkEnableOption "a small portable WezTerm configuration";

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Additional Lua expressions merged into the WezTerm config.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      extraConfig = ''
        local wezterm = require("wezterm")

        ${cfg.extraConfig}

        return {
          enable_tab_bar = false,
          window_close_confirmation = "NeverPrompt",
        }
      '';
    };
  };
}
