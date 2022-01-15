#!/bin/sh

set -o nounset
set -o errexit

prefix=/opt/custom/clang/13.0.0

if [ -d "${prefix}" ]; then
    printf "clang 13.0.0 already installed\n"
    exit 0
fi

git clone --recursive --branch=llvmorg-13.0.0 --depth=1 https://github.com/llvm/llvm-project.git
pushd llvm-project
cmake -S llvm -B build -G "Ninja"                                                                       \
    -DCMAKE_BUILD_TYPE=Release                                                                          \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON                                                                 \
    -DCMAKE_C_COMPILER=/opt/custom/gcc/11.2.0/bin/gcc                                                   \
    -DCMAKE_C_FLAGS=-I/opt/custom/gcc/11.2.0/include                                                    \
    -DCMAKE_CXX_COMPILER=/opt/custom/gcc/11.2.0/bin/g++                                                 \
    -DCMAKE_CXX_FLAGS=-I/opt/custom/gcc/11.2.0/include                                                  \
    -DCMAKE_CXX_LINK_FLAGS="-L/opt/custom/gcc/11.2.0/lib64 -Wl,-rpath,/opt/custom/gcc/11.2.0/lib64"     \
    -DCMAKE_INSTALL_PREFIX="${prefix}"                                                                  \
    -DCMAKE_SHARED_LINKER_FLAGS=-L/opt/custom/gcc/11.2.0/lib64                                          \
    -DCMAKE_VERBOSE_MAKEFILE=ON                                                                         \
    -DGCC_INSTALL_PREFIX=/opt/custom/gcc/11.2.0                                                         \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;libcxxabi;libcxx;libunwind;lld;lldb"    \
    -DLLVM_TARGETS_TO_BUILD=X86
cmake --build build -j20
sudo cmake --install build
popd
rm -rf llvm-project
