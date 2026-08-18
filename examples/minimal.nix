{ ... }:
{
  imports = [ ../modules/dragonix ];

  home.username = "public";
  home.homeDirectory = "/home/public";
  home.stateVersion = "24.11";

  dragonix.profiles.minimal.enable = true;
}
