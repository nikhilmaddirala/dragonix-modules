{ lib, ... }:
{
  imports = (import ../../../lib/import-tree.nix { inherit lib; }) ./.;
}
