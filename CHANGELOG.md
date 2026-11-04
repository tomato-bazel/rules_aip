# Changelog

All notable changes to this module are documented here; this project adheres to
[Keep a Changelog](https://keepachangelog.com/) and [SemVer](https://semver.org/).

## [Unreleased]

## [0.3.1] — 2026-11-04

### Added

- Ship the `googleapis-proto-source` 0.1.0 Cargo package with pinned Google API
  annotation sources for build-time imports. CI verifies package contents,
  consumption through Git, and agreement with the Bazel source dependency.


## [0.3.0] — 2026-07-27

### Changed

- **`aip_proto_lint` resolves `protoc` from the proto toolchain** instead of
  naming `@protobuf//:protoc`. That label is the from-source `cc_binary`, so
  every consumer previously had to fetch **and run** a C++ compiler to lint
  protos — in repos that typically contain no C++ — and
  `--@protobuf//bazel/toolchains:prefer_prebuilt_protoc` was inert, because it
  redirects the toolchain the rule never consulted.

  The cost was concrete: `aion/e2e` carried a `toolchains_llvm` block whose only
  purpose was to satisfy this, and alternated between LLVM 18.1.8 and 20.1.3 —
  18 links `libtinfo.so.5` and dies at exec on workers shipping `.so.6`; 20 loads
  but its tarball fills constrained runners. One root cause, two symptoms, no
  pin correct everywhere.

  The private `_protoc` attribute is **removed** rather than kept as a fallback.
  An `attr.label` default is a dependency edge whether or not the rule reads it,
  so keeping it would still pull the from-source `protoc` through analysis —
  which is exactly what requires the C++ toolchain. Verified by `cquery`:
  `cc_binary @protobuf//:protoc` and `protoc_lib_stage1` are no longer in
  `deps()`, and a consumer builds green on macOS with no cc toolchain registered.

### Requires

- Proto toolchain resolution, which Bazel 9 enables by default. On Bazel 8 or
  older, pass `--incompatible_enable_proto_toolchain_resolution`; the rule now
  fails with that instruction rather than a bare toolchain error.
