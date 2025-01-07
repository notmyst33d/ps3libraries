#!/bin/sh -e
# libpng-1.4.4.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget --continue https://ixpeering.dl.sourceforge.net/project/libpng/libpng14/older-releases/1.4.4/libpng-1.4.4.tar.gz?viasf=1 -O libpng-1.4.4.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget --continue https://raw.githubusercontent.com/arthenica/gnu-config/refs/heads/master/config.guess; fi
if [ ! -f config.sub ]; then wget --continue https://raw.githubusercontent.com/arthenica/gnu-config/refs/heads/master/config.sub; fi

## Unpack the source code.
rm -Rf libpng-1.4.4 && tar xfvz libpng-1.4.4.tar.gz && cd libpng-1.4.4

## Replace config.guess and config.sub
cp ../config.guess ../config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
CPPFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --enable-static --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
