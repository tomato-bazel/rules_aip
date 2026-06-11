"""Module extension that fetches the prebuilt api-linter release binary.

No Go toolchain, no build-from-source — one sha256-pinned binary per platform
from github.com/googleapis/api-linter/releases. Cached in Bazel's downloads
cache, so rebuilds (and lint runs) are offline after the first fetch.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

_VERSION = "2.3.1"

# slug -> sha256 of api-linter-<VERSION>-<slug>.tar.gz (each tarball is a single
# `api-linter` / `api-linter.exe` binary at the root).
_PLATFORMS = {
    "darwin_amd64": ("darwin-amd64", "569019fce994f4b2a1689271c6e932857089222a63105f2ee877fc33851d9dc8"),
    "darwin_arm64": ("darwin-arm64", "09b7a81c3cc8c07e0b6d22a5975c245571a42eb6345787722ea992147ae20c59"),
    "linux_amd64": ("linux-amd64", "c81a07f4d37a61081071f9a8b33553d4db2f9bb058a77db760d1aaf525bbf0eb"),
    "windows_amd64": ("windows-amd64", "da8e2154f96d9ec60c86fdb61b12e43e593a5ba17cbaab19a186f2f066bc796a"),
}

# Robust to the binary name (api-linter vs api-linter.exe): glob it, alias to it.
_BUILD = '''package(default_visibility = ["//visibility:public"])
_bin = glob(["api-linter*"])
exports_files(_bin)
alias(name = "linter", actual = ":" + _bin[0])
'''

def _impl(_ctx):
    for plat, (slug, sha) in _PLATFORMS.items():
        http_archive(
            name = "rules_aip_api_linter_" + plat,
            urls = ["https://github.com/googleapis/api-linter/releases/download/v{v}/api-linter-{v}-{s}.tar.gz".format(v = _VERSION, s = slug)],
            sha256 = sha,
            build_file_content = _BUILD,
        )

api_linter = module_extension(implementation = _impl)
