#!/usr/bin/env bash
set -euo pipefail

# Ensure submodules are initialized
echo "==> Initializing git submodules..."
git submodule update --init --recursive

usage() {
    echo "Usage: ./build.sh [OPTIONS]"
    echo ""
    echo "  -c=<compiler>   gcc | clang (default) | intel"
    echo "  -t=<type>       debug | release (default) | relwithdebinfo"
    echo "  -j=<N>          parallel jobs (default: 1)"
    echo "  -h, --help      show this help"
    echo ""
    echo "Examples:"
    echo "  ./build.sh                          # clang release, 1 job"
    echo "  ./build.sh -c=gcc -t=debug          # gcc debug"
    echo "  ./build.sh -c=clang -j=4            # clang release, 4 jobs"
    echo "  ./build.sh -c=gcc -t=relwithdebinfo -j=8"
    exit 1
}

COMPILER="clang"
BUILD_TYPE="release"
JOBS=1

for arg in "$@"; do
    case "$arg" in
        -c=*) COMPILER="${arg#*=}" ;;
        -t=*) BUILD_TYPE="${arg#*=}" ;;
        -j=*) JOBS="${arg#*=}" ;;
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

echo "==> Building with ${JOBS} job(s)..."
cmake --build "${BUILD_DIR}" -j"${JOBS}"

echo "==> Done"
file bin/*/adminskit_amxx_i386.so 2>/dev/null || true
