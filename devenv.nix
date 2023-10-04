{pkgs, ...}: let
  bazel =
    pkgs.writeScriptBin "bazel"
    ''${pkgs.bazelisk}/bin/bazelisk "$@"'';
in {
  # If you don't want to install nix, you can use it via a docker container in VSCode.
  # devcontainer.enable = true;
  containers."shell".copyToRoot = null;
  # Fancy prompt.
  starship.enable = true;

  # https://devenv.sh/basics/
  # https://devenv.sh/languages/
  languages = {
    rust.enable = true;
    typescript.enable = true;
  };

  # https://devenv.sh/packages/
  packages = [
    # Include it or use system git?
    pkgs.git
    pkgs.cacert

    # Bazel
    pkgs.bazel_6
    pkgs.bazel-buildtools

    # TypeScript
    pkgs.nodePackages.pnpm
  ];

  # https://devenv.sh/scripts/
  # scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    # shellcheck.enable = true;
    # shfmt.enable = true;

    # nix reformat
    # alejandra.enable = true;
    # nix lint
    # statix.enable = true;

    rustfmt.enable = true;

    # markdownlint.enable = true;
    # https://zimbatm.github.io/mdsh/
    # mdsh.enable = true;

    prettier.enable = true;

    # yamllint.enable = true;
  };

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
