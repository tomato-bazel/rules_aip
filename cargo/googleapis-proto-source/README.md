# googleapis-proto-source

A source-only Cargo package exporting `google/api/field_behavior.proto` through
`googleapis_proto_source::include_dir()`. It supplies no generated Rust message
types, runtime dependencies, compiler, build script, or network fetch step.

Use it as a pinned build dependency when a native Cargo build must resolve
Google API field-behavior annotations. Pass `include_dir()` to the compiler
alongside the project's own proto root and the compiler's well-known-type include
directory. For example, with `protoc-bin-vendored`:

```rust,ignore
let includes = [
    std::path::PathBuf::from("proto"),
    googleapis_proto_source::include_dir(),
    protoc_bin_vendored::include_path()?,
];
```

The dependent build script should declare the imported proto as a
`cargo:rerun-if-changed` input when supporting local source overrides. Source
acquisition belongs to Cargo's ordinary dependency resolution; the build script
does not need Bazel or a network connection.

## Source and license

The packaged file is byte-identical to
[`google/api/field_behavior.proto`](https://github.com/googleapis/googleapis/blob/20ac242a6b3a723cb10c1a0201209261addaf7d8/google/api/field_behavior.proto)
from Google APIs commit `20ac242a6b3a723cb10c1a0201209261addaf7d8`, matching
`googleapis` module version `0.0.0-20260422-20ac242a` in this repository.

- File length: 4,306 bytes.
- SHA-256: `bb7ed77725c95f751ec2c47cd92359d0137c39383b8a62aef41bab7aa7478da5`.
- License: Apache-2.0; the upstream copyright header and license are included.

`bazel test //cargo/googleapis-proto-source:canonical_source_test` compares the
packaged source directly with the declared `@googleapis` source. Update the
module pin, source file, and provenance together when deliberately upgrading.
