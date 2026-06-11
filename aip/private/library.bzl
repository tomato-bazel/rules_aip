"""aip_proto_library — proto_library that bundles the standard googleapis AIP deps,

so AIP-conformant protos stop re-listing field_behavior / resource / annotations /
client on every target. Reach for the `AIP_*` dep-group constants when you need
the less-universal ones (LRO, well-known types).
"""

load("@protobuf//bazel:proto_library.bzl", "proto_library")

# The near-universal AIP imports (field_behavior, resource, annotations, client).
AIP_COMMON_DEPS = [
    "@googleapis//google/api:field_behavior_proto",
    "@googleapis//google/api:resource_proto",
    "@googleapis//google/api:annotations_proto",
    "@googleapis//google/api:client_proto",
]

# Long-running operations (AIP-151).
AIP_LRO_DEPS = [
    "@googleapis//google/longrunning:operations_proto",
]

# Common well-known types used across AIP request/response shapes.
AIP_WKT_DEPS = [
    "@protobuf//:timestamp_proto",
    "@protobuf//:field_mask_proto",
    "@protobuf//:duration_proto",
    "@protobuf//:empty_proto",
]

def aip_proto_library(name, srcs, deps = [], aip_deps = AIP_COMMON_DEPS, **kwargs):
    """proto_library + the standard AIP googleapis deps.

    Args:
      name: target name.
      srcs: .proto sources.
      deps: additional proto_library deps (your own + e.g. AIP_LRO_DEPS / AIP_WKT_DEPS).
      aip_deps: the AIP staple deps to include (default AIP_COMMON_DEPS; pass [] to opt out).
      **kwargs: forwarded to proto_library (strip_import_prefix, visibility, …).
    """
    proto_library(
        name = name,
        srcs = srcs,
        deps = deps + aip_deps,
        **kwargs
    )
