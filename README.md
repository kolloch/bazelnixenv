# bazelnixenv

```
bazel clean && bazel build //rust/hello
```

devenv version 0.6.3

- ✅ Ubuntu + nix + direnv
- ✅ Ubuntu + devenv shell
- ❌ Ubuntu + VSCode + devcontainer

  ```
  INFO: Starting clean (this may take a while). Consider using --async if the clean takes more than several minutes.
  INFO: Analyzed target //rust/hello:hello (113 packages loaded, 1157 targets configured).
  INFO: Found 1 target...
  INFO: From BazelWorkspaceStatusAction stable-status.txt:
  Getting workspace status...
  Found docker config at /home/vscode/.docker/config.json
  ERROR: /home/vscode/.cache/bazel/_bazel_vscode/4d244788110239ed3b7edb9dd476fb2a/external/crate_index__serde-1.0.188/BUILD.bazel:22:13: Compiling Rust rlib serde v1.0.188 (20 files) failed: (Exit 1): process_wrapper failed: error executing command (from target @crate_index__serde-1.0.188//:serde) bazel-out/k8-opt-exec-2B5CBBC6/bin/external/rules_rust/util/process_wrapper/process_wrapper --env-file bazel-out/k8-fastbuild/bin/external/crate_index__serde-1.0.188/serde_build_script.env --arg-file ... (remaining 36 arguments skipped)

  Use --sandbox_debug to see verbose messages from the sandbox and retain the sandbox build root for debugging
  error: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.36' not found (required by /nix/store/xpxln7rqi3pq4m0xpnawhxb2gs0mn1s0-gcc-12.3.0-lib/lib/libstdc++.so.6)
  --> external/crate_index__serde-1.0.188/src/lib.rs:318:1
      |
  318 | extern crate serde_derive;
      | ^^^^^^^^^^^^^^^^^^^^^^^^^^

  error: aborting due to previous error

  Aspect @rules_rust//rust/private:clippy.bzl%rust_clippy_aspect of //rust/hello:hello failed to build
  Use --verbose_failures to see the command lines of failed build steps.
  INFO: Elapsed time: 43.592s, Critical Path: 29.13s
  INFO: 115 processes: 102 internal, 13 linux-sandbox.
  FAILED: Build did NOT complete successfully
  ```
