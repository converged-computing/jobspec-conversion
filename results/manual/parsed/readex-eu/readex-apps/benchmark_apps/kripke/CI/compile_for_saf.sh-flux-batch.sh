#!/bin/bash
#FLUX: --job-name=salted-squidward-2259
#FLUX: -c=24
#FLUX: --urgency=16

export CXX='scorep --nomemory $READEX_CXX'

cd ..
. readex_env/set_env_saf.source
. $(pwd)/environment.sh
cp CMakeLists-PLAIN.txt CMakeLists.txt	#without any manualy inserted region
export CXX="scorep --nomemory $READEX_CXX"
rm -rf build
mkdir build
cd build
cmake ..
make
cp ../scripts/do_scorep_autofilter_single.sh .
cp ../scripts/run_saf.sh .
