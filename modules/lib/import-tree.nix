{ lib }:
let
  importTree =
    directory:
    builtins.concatLists (
      map (
        name:
        let
          kind = (builtins.readDir directory).${name};
          path = directory + "/${name}";
        in
        if kind == "directory" then
          importTree path
        else if kind == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" then
          [ path ]
        else
          [ ]
      ) (lib.attrNames (builtins.readDir directory))
    );
in
importTree
