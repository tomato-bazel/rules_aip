//! Pinned Google API annotation sources for native Cargo build scripts.
//!
//! This crate exports source paths, not generated message or runtime types.
//! Cargo acquires the source package before a dependent build script executes;
//! this crate has no dependencies, build script, compiler, or network access.

use std::path::PathBuf;

/// Returns the directory containing `google/api/field_behavior.proto`.
///
/// Add this directory to the proto compiler's include paths. The well-known
/// `google/protobuf/descriptor.proto` imported by that file belongs to the
/// caller's protobuf compiler distribution and is not duplicated here.
pub fn include_dir() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("proto")
}
