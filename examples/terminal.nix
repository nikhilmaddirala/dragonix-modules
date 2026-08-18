{ ... }:
{
  imports = [ ../modules/dragonix ];

  home.username = "public";
  home.homeDirectory = "/home/public";
  home.stateVersion = "24.11";

  dragonix.profiles.terminal.enable = true;
  dragonix.features.programs.terminal.zellij.enable = true;
  dragonix.features.programs.terminal.wezterm.enable = true;
}
