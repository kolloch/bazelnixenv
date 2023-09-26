load("@crate_index//:defs.bzl", "aliases", "all_crate_deps")
load("@rules_rust//rust:defs.bzl", "rust_binary", "rust_test")
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_push", "oci_tarball")

def nx_rust_bin(
        name,
        bin_additional_deps = [],
        bin_compile_data = [],
        image_prepend_tars = [],
        **kwargs):
    """ Handles a typical rust binary including building an OCI image.

    Args:
        name: The name of the generated rust_binary target and the prefix for other targets.
        bin_additional_deps: Additional dependencies for the rust_binary not covered through `all_crate_deps`.
        bin_compile_data: Data for the rust binary.
        image_prepend_tars: Additional tar layers to prepend to the docker file.
        **kwargs: Additional arguments passed to the rust_binary rule.
    """

    rust_binary(
        name = name,
        # Specifies the source file for the binary.
        srcs = native.glob(["src/**"]),
        aliases = aliases(
            normal_dev = True,
            proc_macro = True,
        ),
        compile_data = bin_compile_data,
        proc_macro_deps = all_crate_deps(
            proc_macro = True,
        ),
        deps = all_crate_deps(
            normal = True,
        ) + bin_additional_deps,
        stamp = 0,
        **kwargs
    )

def nx_rust_test(
        name,
        additional_deps = [],
        size = "small",
        **kwargs):
    rust_test(
        name = name,
        aliases = aliases(
            normal_dev = True,
            proc_macro_dev = True,
        ),
        proc_macro_deps = all_crate_deps(
            proc_macro_dev = True,
        ),
        size = size,
        stamp = 0,
        deps = all_crate_deps(
            normal_dev = True,
        ) + additional_deps,
        **kwargs
    )
