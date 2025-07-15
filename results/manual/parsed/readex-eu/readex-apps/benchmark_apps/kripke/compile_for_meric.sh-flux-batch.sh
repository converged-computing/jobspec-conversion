#!/bin/bash
#FLUX: --job-name=red-pastry-2243
#FLUX: -c=24
#FLUX: --priority=16

export CXX='$READEX_CXX'

. readex_env/set_env_meric.source
. scripts_$READEX_MACHINE/environment.sh
cp CMakeLists-MERIC.txt CMakeLists.txt
export CXX=$READEX_CXX
rm -rf build
mkdir build
cd build
cmake ..
make
