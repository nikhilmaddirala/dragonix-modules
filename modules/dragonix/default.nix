{ lib, ... }:
{
  imports = [
    ../profiles
    ../public
    ../programs/cli
    ../programs/nix
    ../programs/terminal
  ]
  ++ (import ../lib/import-tree.nix { inherit lib; }) ../programs/public
  ++ (import ../lib/import-tree.nix { inherit lib; }) ../system/public;
}
