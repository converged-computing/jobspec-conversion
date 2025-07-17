#!/bin/bash
#FLUX: --job-name=blank-truffle-1072
#FLUX: -c=24
#FLUX: -t=1800
#FLUX: --urgency=16

export CXX='scorep --online-access --user --mpp=mpi --thread=none --nomemory $FILTER_GCC $READEX_CXX $FILTER_ICC'

cd ..
. readex_env/set_env_ptf_hdeem.source
. $(pwd)/environment.sh
cp CMakeLists-SCOREP-PHASE.txt CMakeLists.txt
if [ $READEX_INTEL ]
then
        FILTER_ICC="-tcollect-filter=$(pwd)/RESULTS/scorep_icc.filt"
else
        FILTER_GCC="--instrument-filter=$(pwd)/RESULTS/scorep.filt"
fi
export CXX="scorep --online-access --user --mpp=mpi --thread=none --nomemory $FILTER_GCC $READEX_CXX $FILTER_ICC"
rm -rf build
mkdir build
cd build
cmake ..
make
cp ../scripts/run_ptf.sh .
cp ../scripts/run_rrl.sh .
