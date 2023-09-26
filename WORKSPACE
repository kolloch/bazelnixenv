workspace(name = "nx0")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

###
# buildbuddy
###

http_archive(
    name = "io_buildbuddy_buildbuddy_toolchain",
    sha256 = "1cab6ef3ae9b4211ab9d57826edd4bbc34e5b9e5cb1927c97f0788d8e7ad0442",
    strip_prefix = "buildbuddy-toolchain-b043878a82f266fd78369b794a105b57dc0b2600",
    urls = ["https://github.com/buildbuddy-io/buildbuddy-toolchain/archive/b043878a82f266fd78369b794a105b57dc0b2600.tar.gz"],
)

load("@io_buildbuddy_buildbuddy_toolchain//:deps.bzl", "buildbuddy_deps")

buildbuddy_deps()

load("@io_buildbuddy_buildbuddy_toolchain//:rules.bzl", "UBUNTU20_04_IMAGE", "buildbuddy")

buildbuddy(
    name = "buildbuddy_toolchain",
    container_image = UBUNTU20_04_IMAGE,
)

###
# rules_rust
###

http_archive(
    name = "rules_rust",
    sha256 = "9d04e658878d23f4b00163a72da3db03ddb451273eb347df7d7c50838d698f49",
    urls = ["https://github.com/bazelbuild/rules_rust/releases/download/0.26.0/rules_rust-v0.26.0.tar.gz"],
)

load("@rules_rust//rust:repositories.bzl", "rules_rust_dependencies", "rust_analyzer_toolchain_repository", "rust_register_toolchains")

rules_rust_dependencies()

# Please keep this in sync with the rust_version in .devcontainer/Dockerfile
rust_version = "1.72.0"

rust_register_toolchains(
    edition = "2021",
    versions = [
        rust_version,
    ],
)

load("@rules_rust//tools/rust_analyzer:deps.bzl", "rust_analyzer_dependencies")

rust_analyzer_dependencies()

register_toolchains(rust_analyzer_toolchain_repository(
    name = "rust_analyzer_toolchain",
    version = rust_version,
))

load("@rules_rust//crate_universe:repositories.bzl", "crate_universe_dependencies")

crate_universe_dependencies()

load("@rules_rust//crate_universe:defs.bzl", "crates_repository")

crates_repository(
    name = "crate_index",
    cargo_lockfile = "//:Cargo.lock",
    lockfile = "//:cargo-bazel-lock.json",
    manifests = [
        "//:Cargo.toml",
        "//rust/hello:Cargo.toml",
    ],
)

load("@crate_index//:defs.bzl", "crate_repositories")

crate_repositories()

###
# GRPC/Protobuf
###

http_archive(
    name = "com_google_protobuf",
    sha256 = "fad09052bea8f0183c8e91fd32d811cf1c9fcc80222edc28c2854bb8e484403a",
    strip_prefix = "protobuf-24.2",
    urls = ["https://github.com/protocolbuffers/protobuf/archive/refs/tags/v24.2.zip"],
)

http_archive(
    name = "rules_proto_grpc",
    sha256 = "928e4205f701b7798ce32f3d2171c1918b363e9a600390a25c876f075f1efc0a",
    strip_prefix = "rules_proto_grpc-4.4.0",
    urls = ["https://github.com/rules-proto-grpc/rules_proto_grpc/releases/download/4.4.0/rules_proto_grpc-4.4.0.tar.gz"],
)

load("@rules_proto_grpc//:repositories.bzl", "rules_proto_grpc_repos", "rules_proto_grpc_toolchains")

rules_proto_grpc_toolchains()

rules_proto_grpc_repos()

load("@rules_proto//proto:repositories.bzl", "rules_proto_dependencies", "rules_proto_toolchains")

rules_proto_dependencies()

rules_proto_toolchains()

###
# Rules Go
###

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "278b7ff5a826f3dc10f04feaf0b70d48b68748ccd512d7f98bf442077f043fe3",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.41.0/rules_go-v0.41.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.41.0/rules_go-v0.41.0.zip",
    ],
)

# Download Gazelle.
http_archive(
    name = "bazel_gazelle",
    sha256 = "29218f8e0cebe583643cbf93cae6f971be8a2484cdcfa1e45057658df8d54002",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.32.0/bazel-gazelle-v0.32.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.32.0/bazel-gazelle-v0.32.0.tar.gz",
    ],
)

# Load macros and repository rules.
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

# Declare indirect dependencies and register toolchains.
go_rules_dependencies()

go_register_toolchains(version = "1.20.5")

gazelle_dependencies()

# gazelle Python support
http_archive(
    name = "rules_python_gazelle_plugin",
    sha256 = "5868e73107a8e85d8f323806e60cad7283f34b32163ea6ff1020cf27abef6036",
    strip_prefix = "rules_python-0.25.0/gazelle",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.25.0/rules_python-0.25.0.tar.gz",
)

# To compile the rules_python gazelle extension from source,
# we must fetch some third-party go dependencies that it uses.

load("@rules_python_gazelle_plugin//:deps.bzl", _py_gazelle_deps = "gazelle_deps")

_py_gazelle_deps()

###
# Kotlin
###

http_archive(
    name = "io_bazel_rules_kotlin",
    sha256 = "01293740a16e474669aba5b5a1fe3d368de5832442f164e4fbfc566815a8bc3a",
    urls = ["https://github.com/bazelbuild/rules_kotlin/releases/download/v1.8/rules_kotlin_release.tgz"],
)

load("@io_bazel_rules_kotlin//kotlin:repositories.bzl", "kotlin_repositories")

kotlin_repositories()  # if you want the default. Otherwise see custom kotlinc distribution below

register_toolchains("//:kotlin_toolchain")

###
# JVM
###

http_archive(
    name = "rules_jvm_external",
    patch_args = ["-p1"],
    patches = [
        "@nx0//:bazel/rules_jvm_external-netrc.patch",
    ],
    sha256 = "d31e369b854322ca5098ea12c69d7175ded971435e55c18dd9dd5f29cc5249ac",
    strip_prefix = "rules_jvm_external-5.3",
    url = "https://github.com/bazelbuild/rules_jvm_external/releases/download/5.3/rules_jvm_external-5.3.tar.gz",
)

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")

# special handling for binary dependencies, see https://github.com/bazelbuild/rules_jvm_external/issues/132
http_file(
    name = "com_almworks_sqlite4java_libsqlite4java_linux_amd64",
    downloaded_file_path = "libsqlite4java-linux-amd64.so",
    sha256 = "da3d7d21eef476baf644026e449b392dbd738bf9246fca48ce072987264c3aca",
    urls = ["https://repo1.maven.org/maven2/com/almworks/sqlite4java/libsqlite4java-linux-amd64/1.0.392/libsqlite4java-linux-amd64-1.0.392.so"],
)

http_file(
    name = "com_almworks_sqlite4java_libsqlite4java_osx",
    downloaded_file_path = "libsqlite4java-osx.dylib",
    sha256 = "b84122142173f33137c76d05dd6c80cc96f619ead3dc476c12d6ea46ef12dd05",
    urls = ["https://repo1.maven.org/maven2/com/almworks/sqlite4java/libsqlite4java-osx/1.0.392/libsqlite4java-osx-1.0.392.dylib"],
)

http_file(
    name = "com_almworks_sqlite4java_libsqlite4java_win32_amd64",
    downloaded_file_path = "libsqlite4java-win32-x64.dll",
    sha256 = "6f4e9a4e1635ba38b2f5d88b3d99be3062f4ed26aea0fa035bde6d0107c308e6",
    urls = ["https://repo1.maven.org/maven2/com/almworks/sqlite4java/sqlite4java-win32-x64/1.0.392/sqlite4java-win32-x64-1.0.392.dll"],
)

maven_install(
    name = "maven",
    artifacts = [
        maven.artifact(
            artifact = "DynamoDBLocal",
            exclusions = [
                "com.almworks.sqlite4java:libsqlite4java-linux-amd64",
                "com.almworks.sqlite4java:libsqlite4java-linux-i386",
                "com.almworks.sqlite4java:libsqlite4java-osx",
                "com.almworks.sqlite4java:sqlite4java-win32-x64",
                "com.almworks.sqlite4java:sqlite4java-win32-x86",
                "org.eclipse.jetty.orbit:javax.servlet",
            ],
            group = "com.amazonaws",
            version = "1.21.1",
        ),
        ## START: AUTOMANAGED DEPENDENCIES
        "aopalliance:aopalliance:1.0",
        "asm:asm:3.1",
        "ch.hsr:geohash:1.1.0",
        "commons-codec:commons-codec:1.15",
        "commons-io:commons-io:2.11.0",
        "commons-logging:commons-logging:1.2",
        "io.ktor:ktor-client-apache-jvm:2.3.1",
        "io.ktor:ktor-client-apache:2.3.1",
        "io.ktor:ktor-client-auth-jvm:2.3.1",
        "io.ktor:ktor-client-auth:2.3.1",
        "io.ktor:ktor-client-cio-jvm:2.3.1",
        "io.ktor:ktor-client-cio:2.3.1",
        "io.ktor:ktor-client-content-negotiation-jvm:2.3.1",
        "io.ktor:ktor-client-content-negotiation:2.3.1",
        "io.ktor:ktor-client-core-jvm:2.3.3",
        "io.ktor:ktor-client-core:2.3.3",
        "io.ktor:ktor-client-jetty-jvm:2.2.3",
        "io.ktor:ktor-client-jetty:2.2.3",
        "io.ktor:ktor-client-logging-jvm:2.3.1",
        "io.ktor:ktor-client-logging:2.3.1",
        "io.ktor:ktor-client-okhttp-jvm:2.3.1",
        "io.ktor:ktor-client-okhttp:2.3.1",
        "io.ktor:ktor-events-jvm:2.3.3",
        "io.ktor:ktor-events:2.3.3",
        "io.ktor:ktor-http-cio-jvm:2.3.1",
        "io.ktor:ktor-http-cio:2.3.1",
        "io.ktor:ktor-http-jvm:2.3.2",
        "io.ktor:ktor-http:2.3.3",
        "io.ktor:ktor-io-jvm:2.3.2",
        "io.ktor:ktor-io:2.3.3",
        "io.ktor:ktor-network-jvm:2.3.1",
        "io.ktor:ktor-network-tls-certificates-jvm:2.2.3",
        "io.ktor:ktor-network-tls-certificates:2.2.3",
        "io.ktor:ktor-network-tls-jvm:2.3.1",
        "io.ktor:ktor-network-tls:2.3.1",
        "io.ktor:ktor-network:2.3.1",
        "io.ktor:ktor-serialization-jackson-jvm:2.2.3",
        "io.ktor:ktor-serialization-jackson:2.2.3",
        "io.ktor:ktor-serialization-jvm:2.3.3",
        "io.ktor:ktor-serialization-kotlinx-json-jvm:2.3.1",
        "io.ktor:ktor-serialization-kotlinx-json:2.3.1",
        "io.ktor:ktor-serialization-kotlinx-jvm:2.3.1",
        "io.ktor:ktor-serialization-kotlinx:2.3.1",
        "io.ktor:ktor-serialization:2.3.3",
        "io.ktor:ktor-server-auth-jvm:2.3.3",
        "io.ktor:ktor-server-auth-jwt-jvm:2.1.1",
        "io.ktor:ktor-server-auth-jwt:2.1.1",
        "io.ktor:ktor-server-auth:2.3.3",
        "io.ktor:ktor-server-call-logging-jvm:2.2.3",
        "io.ktor:ktor-server-call-logging:2.3.2",
        "io.ktor:ktor-server-content-negotiation-jvm:2.2.3",
        "io.ktor:ktor-server-content-negotiation:2.2.3",
        "io.ktor:ktor-server-core-jvm:2.3.3",
        "io.ktor:ktor-server-core:2.3.3",
        "io.ktor:ktor-server-host-common-jvm:2.2.3",
        "io.ktor:ktor-server-host-common:2.2.3",
        "io.ktor:ktor-server-metrics-micrometer-jvm:2.3.2",
        "io.ktor:ktor-server-metrics-micrometer:2.3.2",
        "io.ktor:ktor-server-netty-jvm:2.2.3",
        "io.ktor:ktor-server-netty:2.3.2",
        "io.ktor:ktor-server-sessions-jvm:2.3.3",
        "io.ktor:ktor-server-sessions:2.3.2",
        "io.ktor:ktor-server-status-pages-jvm:2.2.3",
        "io.ktor:ktor-server-status-pages:2.3.2",
        "io.ktor:ktor-server-test-host-jvm:2.2.3",
        "io.ktor:ktor-server-test-host:2.2.3",
        "io.ktor:ktor-server-websockets-jvm:2.2.3",
        "io.ktor:ktor-server-websockets:2.2.3",
        "io.ktor:ktor-test-dispatcher-jvm:2.2.3",
        "io.ktor:ktor-test-dispatcher:2.2.3",
        "io.ktor:ktor-utils-jvm:2.3.2",
        "io.ktor:ktor-utils:2.3.3",
        "io.ktor:ktor-websocket-serialization-jvm:2.3.2",
        "io.ktor:ktor-websocket-serialization:2.3.3",
        "io.ktor:ktor-websockets-jvm:2.3.2",
        "io.ktor:ktor-websockets:2.3.2",
        "io.leonard:google-polyline-codec:0.0.2",
        "io.micrometer:micrometer-core:1.5.2",
        "io.micrometer:micrometer-core:1.7.5",
        "io.micrometer:micrometer-registry-datadog:1.5.2",
        "io.mockk:mockk-agent-api-jvm:1.13.5",
        "io.mockk:mockk-agent-api:1.13.5",
        "io.mockk:mockk-agent-common:1.12.5",
        "io.mockk:mockk-agent-jvm:1.13.5",
        "io.mockk:mockk-agent:1.13.5",
        "io.mockk:mockk-common:1.12.5",
        "io.mockk:mockk-dsl-jvm:1.13.5",
        "io.mockk:mockk-dsl:1.13.5",
        "io.mockk:mockk-jvm:1.13.5",
        "io.mockk:mockk:1.13.5",
        "io.netty:netty-buffer:4.1.86.Final",
        "io.netty:netty-codec-dns:4.1.86.Final",
        "io.netty:netty-codec-http2:4.1.86.Final",
        "io.netty:netty-codec-http:4.1.86.Final",
        "io.netty:netty-codec-socks:4.1.86.Final",
        "io.netty:netty-codec:4.1.86.Final",
        "io.netty:netty-common:4.1.86.Final",
        "io.netty:netty-handler-proxy:4.1.86.Final",
        "io.netty:netty-handler:4.1.86.Final",
        "io.netty:netty-resolver-dns:4.1.86.Final",
        "io.netty:netty-resolver:4.1.86.Final",
        "io.netty:netty-transport-classes-epoll:4.1.86.Final",
        "io.netty:netty-transport-classes-kqueue:4.1.86.Final",
        "io.netty:netty-transport-native-epoll:4.1.86.Final",
        "io.netty:netty-transport-native-kqueue:4.1.86.Final",
        "io.netty:netty-transport-native-unix-common:4.1.86.Final",
        "io.netty:netty-transport:4.1.86.Final",
        ## END: AUTOMANAGED DEPENDENCIES
    ],
    excluded_artifacts = [
        #        "org.slf4j:slf4j-api",
        "org.apache.logging.log4j:log4j-slf4j-impl",
    ],
    fail_on_missing_checksum = True,
    fetch_sources = True,
    # FIXME: Faster builds but annoying as is and errors
    maven_install_json = "@//:maven_install.json",
    repositories = [
        "https://maven.google.com",
        "https://repo1.maven.org/maven2",
    ],
    resolve_timeout = 600,
    use_credentials_from_home_netrc_file = True,
    version_conflict_policy = "pinned",
)

load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

http_archive(
    name = "contrib_rules_jvm",
    sha256 = "bd0f82def1879df85ff0a80767e6455911e1c9c1eac5db1de8f68dcccd4a3d7a",
    strip_prefix = "rules_jvm-0.18.0",
    url = "https://github.com/bazel-contrib/rules_jvm/releases/download/v0.18.0/rules_jvm-v0.18.0.tar.gz",
)

load("@contrib_rules_jvm//:repositories.bzl", "contrib_rules_jvm_deps", "contrib_rules_jvm_gazelle_deps")

contrib_rules_jvm_deps()

contrib_rules_jvm_gazelle_deps()

load("@contrib_rules_jvm//:setup.bzl", "contrib_rules_jvm_setup")

contrib_rules_jvm_setup()

# Gazelle integration

load("@contrib_rules_jvm//:gazelle_setup.bzl", "contrib_rules_jvm_gazelle_setup")

contrib_rules_jvm_gazelle_setup()

###
# packaging
###

http_archive(
    name = "rules_pkg",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.9.1/rules_pkg-0.9.1.tar.gz",
    ],
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

###
# Rules OCI
###
#
http_archive(
    name = "rules_oci",
    patch_args = ["-p1"],
    patches = [
        "@nx0//:bazel/rules_oci-gitlab-auth.patch",
    ],
    sha256 = "a3b6f4c0051938940ccf251a7bdcdf7ac5a93ae00e63ad107c9c6d3bfe20885b",
    strip_prefix = "rules_oci-1.3.1",
    url = "https://github.com/bazel-contrib/rules_oci/releases/download/v1.3.1/rules_oci-v1.3.1.tar.gz",
)

load("@rules_oci//oci:dependencies.bzl", "rules_oci_dependencies")

rules_oci_dependencies()

load("@rules_oci//oci:repositories.bzl", "LATEST_CRANE_VERSION", "oci_register_toolchains")

oci_register_toolchains(
    name = "oci",
    crane_version = LATEST_CRANE_VERSION,
    # Uncommenting the zot toolchain will cause it to be used instead of crane for some tasks.
    # Note that it does not support docker-format images.
    # zot_version = LATEST_ZOT_VERSION,
)

# Pull distroless image

load("@rules_oci//oci:pull.bzl", "oci_pull")

oci_pull(
    name = "java_base_image",
    # TODO: Auto-update
    digest = "sha256:4483576cb2d09ef4f5781a9c5ab5141891a487e16d2758bb6aef04921501b9f1",
    registry = "registry.gitlab.com",
    repository = "nexiot-ag/devops/iot-core/globehopper/docker-base",
    reproducible = True,
)

oci_pull(
    name = "sevo-4.1.0",
    digest = "sha256:cfe6961ea641bcfde94edb6bc6db0fd38fc4e3c216d6df3f11d932a5fb648857",
    registry = "registry.gitlab.com",
    repository = "nexiot-ag/devops/persistence/granit/sevo",
    reproducible = True,
)

oci_pull(
    name = "connect_granit",
    registry = "registry.gitlab.com",
    repository = "nexiot-ag/devops/iot-core/connect/connect/granit",
    tag = "latest",
    reproducible = False,
)

#####
# aspect_bazel_lib
#####

http_archive(
    name = "aspect_bazel_lib",
    sha256 = "44f4f6d1ea1fc5a79ed6ca83f875038fee0a0c47db4f9c9beed097e56f8fad03",
    strip_prefix = "bazel-lib-1.34.0",
    url = "https://github.com/aspect-build/bazel-lib/releases/download/v1.34.0/bazel-lib-v1.34.0.tar.gz",
)

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies", "register_jq_toolchains", "register_yq_toolchains")

aspect_bazel_lib_dependencies()

register_jq_toolchains()

register_yq_toolchains()

#####
# bazel-tools
#####

http_archive(
    name = "com_github_ash2k_bazel_tools",
    sha256 = "78fced0aba16794359865301aefb5ba78c22e1f50df104df608e59f4e653fa7a",
    strip_prefix = "bazel-tools-2add5bb84c2837a82a44b57e83c7414247aed43a",
    url = "https://github.com/ash2k/bazel-tools/archive/2add5bb84c2837a82a44b57e83c7414247aed43a.zip",
)

load("@com_github_ash2k_bazel_tools//multirun:deps.bzl", "multirun_dependencies")

multirun_dependencies()

####
# Python
####

http_archive(
    name = "rules_python",
    sha256 = "5868e73107a8e85d8f323806e60cad7283f34b32163ea6ff1020cf27abef6036",
    strip_prefix = "rules_python-0.25.0",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.25.0/rules_python-0.25.0.tar.gz",
)

load("@rules_python//python:repositories.bzl", "py_repositories")
load("@rules_python//python:repositories.bzl", "python_register_toolchains")

# Broken

#python_register_toolchains(
#    name = "python_3_11",
#    # Available versions are listed in @rules_python//python:versions.bzl.
#    # We recommend using the same version your team is already standardized on.
#    python_version = "3.11",
#)
#
#load("@python_3_11//:defs.bzl", "interpreter")
#load("@rules_python//python:pip.bzl", "pip_install")
#
#pip_install(
#    name = "python_deps",
#    requirements = ":requirements.txt",
#)
#
#load("@python_deps//:requirements.bzl", "install_deps")
#
#install_deps()

####
# TypeScript/JavaScript/NPM
####

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_rules_js",
    sha256 = "7ab2fbe6d79fb3909ad2bf6dcacfae39adcb31c514efa239dd730b4f147c8097",
    strip_prefix = "rules_js-1.32.1",
    url = "https://github.com/aspect-build/rules_js/releases/download/v1.32.1/rules_js-v1.32.1.tar.gz",
)

http_archive(
    name = "aspect_rules_jest",
    sha256 = "52dc08fd252add240124ef7ccc46df3a505121758dfb96578a3d5f2ebb4c2b40",
    strip_prefix = "rules_jest-0.18.1",
    url = "https://github.com/aspect-build/rules_jest/releases/download/v0.18.1/rules_jest-v0.18.1.tar.gz",
)

load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@aspect_rules_jest//jest:dependencies.bzl", "rules_jest_dependencies")

rules_jest_dependencies()

load("@rules_nodejs//nodejs:repositories.bzl", "DEFAULT_NODE_VERSION", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = DEFAULT_NODE_VERSION,
)

load("@aspect_rules_js//npm:npm_import.bzl", "npm_translate_lock")

npm_translate_lock(
    name = "npm",
    bins = {
        # derived from "bin" attribute in node_modules/next/package.json
        "next": {
            "next": "./dist/bin/next",
        },
    },
    npmrc = "//:.npmrc",
    pnpm_lock = "//:pnpm-lock.yaml",
    verify_node_modules_ignored = "//:.bazelignore",
)

load("@npm//:repositories.bzl", "npm_repositories")

npm_repositories()

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_rules_swc",
    sha256 = "8eb9e42ed166f20cacedfdb22d8d5b31156352eac190fc3347db55603745a2d8",
    strip_prefix = "rules_swc-1.1.0",
    url = "https://github.com/aspect-build/rules_swc/releases/download/v1.1.0/rules_swc-v1.1.0.tar.gz",
)

# load protobuf deps near the end, so that it does not override other rules
load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")

protobuf_deps()

###################
# rules_swc setup #
###################

# Fetches the rules_swc dependencies.
# If you want to have a different version of some dependency,
# you should fetch it *before* calling this.
# Alternatively, you can skip calling this function, so long as you've
# already fetched all the dependencies.
load("@aspect_rules_swc//swc:dependencies.bzl", "rules_swc_dependencies")

rules_swc_dependencies()

# Fetches a SWC cli from
# https://github.com/swc-project/swc/releases
# If you'd rather compile it from source, you can use rules_rust, fetch the project,
# then register the toolchain yourself. (Note, this is not yet documented)
load("@aspect_rules_swc//swc:repositories.bzl", "LATEST_SWC_VERSION", "swc_register_toolchains")

swc_register_toolchains(
    name = "swc",
    swc_version = LATEST_SWC_VERSION,
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "aspect_rules_ts",
    sha256 = "4c3f34fff9f96ffc9c26635d8235a32a23a6797324486c7d23c1dfa477e8b451",
    strip_prefix = "rules_ts-1.4.5",
    url = "https://github.com/aspect-build/rules_ts/releases/download/v1.4.5/rules_ts-v1.4.5.tar.gz",
)

##################
# rules_ts setup #
##################
# Fetches the rules_ts dependencies.
# If you want to have a different version of some dependency,
# you should fetch it *before* calling this.
# Alternatively, you can skip calling this function, so long as you've
# already fetched all the dependencies.
load("@aspect_rules_ts//ts:repositories.bzl", "rules_ts_dependencies")

rules_ts_dependencies(
    # This keeps the TypeScript version in-sync with the editor, which is typically best.
    ts_version_from = "//:package.json",

    # Alternatively, you could pick a specific version, or use
    # load("@aspect_rules_ts//ts:repositories.bzl", "LATEST_TYPESCRIPT_VERSION")
    # ts_version = LATEST_TYPESCRIPT_VERSION
)

# Fetch and register node, if you haven't already
load("@rules_nodejs//nodejs:repositories.bzl", "DEFAULT_NODE_VERSION", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "node",
    node_version = DEFAULT_NODE_VERSION,
)

# Register aspect_bazel_lib toolchains;
# If you use npm_translate_lock or npm_import from aspect_rules_js you can omit this block.
load("@aspect_bazel_lib//lib:repositories.bzl", "register_copy_directory_toolchains", "register_copy_to_directory_toolchains")

register_copy_directory_toolchains()

register_copy_to_directory_toolchains()
