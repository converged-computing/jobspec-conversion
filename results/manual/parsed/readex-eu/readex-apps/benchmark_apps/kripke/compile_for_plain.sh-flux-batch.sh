#!/bin/bash
#FLUX: --job-name=confused-nunchucks-4619
#FLUX: -c=24
#FLUX: --urgency=16

export CXX='$READEX_CXX'

. readex_env/set_env_plain.source
. scripts_$READEX_MACHINE/environment.sh
cp CMakeLists-PLAIN.txt CMakeLists.txt	#without any manualy inserted region
export CXX=$READEX_CXX
rm -rf build
mkdir build
cd build
cmake ..
make
cp ../scripts_$READEX_MACHINE/run_plain* .
