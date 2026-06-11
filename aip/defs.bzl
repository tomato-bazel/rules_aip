"""Public API for rules_aip.

    load("@rules_aip//aip:defs.bzl", "aip_proto_library", "aip_proto_lint", "AIP_LRO_DEPS")
"""

load(
    "//aip/private:library.bzl",
    _AIP_COMMON_DEPS = "AIP_COMMON_DEPS",
    _AIP_LRO_DEPS = "AIP_LRO_DEPS",
    _AIP_WKT_DEPS = "AIP_WKT_DEPS",
    _aip_proto_library = "aip_proto_library",
)
load("//aip/private:lint.bzl", _aip_proto_lint = "aip_proto_lint")

aip_proto_library = _aip_proto_library
aip_proto_lint = _aip_proto_lint
AIP_COMMON_DEPS = _AIP_COMMON_DEPS
AIP_LRO_DEPS = _AIP_LRO_DEPS
AIP_WKT_DEPS = _AIP_WKT_DEPS
