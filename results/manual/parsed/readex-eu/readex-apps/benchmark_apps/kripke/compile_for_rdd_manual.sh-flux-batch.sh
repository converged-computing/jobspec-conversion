#!/bin/bash
#FLUX: --job-name=buttery-carrot-0555
#FLUX: -c=24
#FLUX: --urgency=16

export CXX='scorep --online-access --user --mpp=mpi --thread=none --nomemory --nocompiler $READEX_CXX'

. readex_env/set_env_rdd.source
. scripts_$READEX_MACHINE/environment.sh
cp CMakeLists-SCOREP-MANUAL.txt CMakeLists.txt
export CXX="scorep --online-access --user --mpp=mpi --thread=none --nomemory --nocompiler $READEX_CXX"
rm -rf build
mkdir build
cd build
cmake ..
make
cp ../scripts_$READEX_MACHINE/run_rdd.sh .
