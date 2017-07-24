#!/bin/bash

export CFLAGS="-I$PREFIX/include $CFLAGS"
export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export CPPFLAGS="-I/$PREFIX/include $CPPFLAGS"

pushd gridgen

./configure --prefix=$PREFIX

make
make lib
make shlib
make tests
# For some odd reason make install is not working on Windows' MSYS2 bash.
# We are installing the files manually. See the bld.bat file for the details.
if [[ $(uname) != MINGW* ]]; then
make install
fi

popd
