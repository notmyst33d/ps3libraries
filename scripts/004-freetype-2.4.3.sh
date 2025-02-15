#!/bin/sh -e
# freetype-2.4.3.sh by Naomi Peori (naomi@peori.ca)

## Download the source code.
wget --continue http://download.savannah.gnu.org/releases/freetype/freetype-old/freetype-2.4.3.tar.gz

## Download an up-to-date config.guess and config.sub
if [ ! -f config.guess ]; then wget --continue https://raw.githubusercontent.com/arthenica/gnu-config/refs/heads/master/config.guess; fi
if [ ! -f config.sub ]; then wget --continue https://raw.githubusercontent.com/arthenica/gnu-config/refs/heads/master/config.sub; fi

## Unpack the source code.
rm -Rf freetype-2.4.3 && tar xfvz freetype-2.4.3.tar.gz && cd freetype-2.4.3

## Replace config.guess and config.sub
cp ../config.guess ../config.sub builds/unix/

## Create the build directory.
mkdir build-ppu && cd build-ppu

## freetype insists on GNU make
which gmake 1>/dev/null 2>&1 && MAKE=gmake

## Configure the build.
CFLAGS="-I$PSL1GHT/ppu/include -I$PS3DEV/portlibs/ppu/include" \
LDFLAGS="-L$PSL1GHT/ppu/lib -L$PS3DEV/portlibs/ppu/lib -lrt -llv2" \
PKG_CONFIG_PATH="$PS3DEV/portlibs/ppu/lib/pkgconfig" \
GNUMAKE=$MAKE ../configure --prefix="$PS3DEV/portlibs/ppu" --host="powerpc64-ps3-elf" --disable-shared

## Compile and install.
${MAKE:-make} -j4 && ${MAKE:-make} install
