#!/bin/sh

set -o nounset
set -o errexit


# gcc v11.2.0
# ----------------------------------------------------------------------
git clone --recursive --depth=1 --branch=releases/gcc-11.2.0 https://github.com/gcc-mirror/gcc.git
cd gcc
./contrib/download_prerequisites
mkdir objdir
cd objdir
../configure                        \
    --disable-multilib              \
    --enable-bootstrap              \
    --prefix=/opt/custom/gcc/11.2.0
make -j20
sudo make instal
