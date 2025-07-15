#!/bin/bash
#FLUX: --job-name=butterscotch-avocado-4966
#FLUX: -c=24
#FLUX: --priority=16

export CXX='scorep --online-access --user --mpp=mpi --thread=none --nomemory $FILTER_GCC $READEX_CXX $FILTER_ICC'

. readex_env/set_env_rdd.source
. scripts_$READEX_MACHINE/environment.sh
cp CMakeLists-SCOREP-PHASE.txt CMakeLists.txt
if [ $READEX_INTEL ]
then
        FILTER_ICC="-tcollect-filter=$(pwd)/scripts_$READEX_MACHINE/RESULTSicc/scorep_icc.filt"
	unset FILTER_GCC
else
        FILTER_GCC="--instrument-filter=$(pwd)/scripts_$READEX_MACHINE/RESULTSgcc/scorep.filt"
	unset FILTER_ICC
fi
export CXX="scorep --online-access --user --mpp=mpi --thread=none --nomemory $FILTER_GCC $READEX_CXX $FILTER_ICC"
rm -rf build
mkdir build
cd build
cmake ..
make
cp ../scripts_$READEX_MACHINE/run_rdd.sh .
