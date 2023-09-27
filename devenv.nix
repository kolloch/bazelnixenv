{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/languages/
  languages = {
    c.enable = true;
    nix.enable = true;
    rust.enable = true;
    javascript.enable = true;
    typescript.enable = true;
  };

  # https://devenv.sh/packages/
  packages = [ pkgs.git pkgs.bazel_6 pkgs.nodePackages.pnpm pkgs.gcc ];

  # https://devenv.sh/scripts/
  scripts.hello.exec = "echo hello from $GREET";

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
