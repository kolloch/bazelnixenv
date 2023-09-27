{ nixpkgs ? import <nixpkgs> { } }:

let
  bazel = nixpkgs.writeScriptBin "bazel"
    ''${nixpkgs.bazelisk}/bin/bazelisk "$@"'';
in
nixpkgs.mkShellNoCC {
  name = "nx0";

  shellHook = ''
    echo Welcome to nx0 dev-shell!
  '';

  packages = [ bazel ];
}
