#!/usr/bin/env bash
set -euo pipefail

# Ensure submodules are initialized
echo "==> Initializing git submodules..."
git submodule update --init --recursive

usage() {
    echo "Usage: ./build.sh [COMPILER] [BUILD_TYPE]"
    echo ""
    echo "  COMPILER     clang (default) | gcc | intel"
    echo "  BUILD_TYPE   debug (default) | release | relwithdebinfo"
    echo ""
    echo "Examples:"
    echo "  ./build.sh                    # clang debug"
    echo "  ./build.sh gcc                # gcc debug"
    echo "  ./build.sh clang release      # clang release"
    echo "  ./build.sh gcc release        # gcc release"
    exit 1
}

COMPILER="clang"
BUILD_TYPE="debug"

for arg in "$@"; do
    case "$arg" in
        gcc|clang|intel) COMPILER="$arg" ;;
        debug|release|relwithdebinfo) BUILD_TYPE="$arg" ;;
        -h|--help) usage ;;
        *) echo "Unknown argument: $arg"; usage ;;
    esac
done

PRESET="linux-${COMPILER}-${BUILD_TYPE}"
BUILD_DIR="out/${PRESET}"

# Clean previous build if it exists
if [ -d "${BUILD_DIR}" ]; then
    echo "==> Cleaning previous build: ${BUILD_DIR}"
    rm -rf "${BUILD_DIR}"
fi

echo "==> Configuring with preset: ${PRESET}"
cmake --preset "${PRESET}"

echo "==> Building..."
cmake --build "${BUILD_DIR}" -j"$(nproc)"

echo "==> Done"
file bin/*/adminskit_amxx_i386.so 2>/dev/null || true
