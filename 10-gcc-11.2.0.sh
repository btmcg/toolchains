#!/bin/sh

set -o nounset
set -o errexit

prefix=/opt/custom/gcc/11.2.0

if [ -d "${prefix}" ]; then
    printf "gcc 11.2.0 already installed\n"
    exit 0
fi

git clone --recursive --branch=releases/gcc-11.2.0 --depth=1 https://github.com/gcc-mirror/gcc.git
curl --remote-name https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.gz
tar xf binutils-2.36.tar.gz

pushd gcc
for file in ../binutils-2.36/* ; do
    ln --symbolic "${file}" &> /dev/null || /bin/true ;
done
./contrib/download_prerequisites
mkdir objdir
cd objdir
../configure            \
    --disable-multilib  \
    --enable-bootstrap  \
    --prefix="${prefix}"
make -j20
sudo make install
popd
rm -rf gcc binutils-2.36.tar.gz binutils-2.36
