#!/bin/sh -e
# libmad-0.15.1b.sh by dhewg (dhewg@wiibrew.org)

## Download the source code.
wget --continue http://downloads.sourceforge.net/project/mad/libmad/0.15.1b/libmad-0.15.1b.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget --continue https://raw.githubusercontent.com/arthenica/gnu-config/refs/heads/master/config.guess; fi
if [ ! -f config.sub ]; then wget --continue https://raw.githubusercontent.com/arthenica/gnu-config/refs/heads/master/config.sub; fi

## Unpack the source code.
rm -Rf libmad-0.15.1b && tar xfvz libmad-0.15.1b.tar.gz && cd libmad-0.15.1b

## Replace config.guess and config.sub
cp ../config.guess ../config.sub .

## Create the build directory.
mkdir build-ppu && cd build-ppu

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
