#!/bin/bash
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=62000
#SBATCH --time=00:30:00

export CXX='scorep --online-access --user --mpp=mpi --thread=none --nomemory $FILTER_GCC $READEX_CXX $FILTER_ICC'

cd ..
. readex_env/set_env_rdd.source
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
cp ../scripts/run_rdd.sh .
cp ../scripts/extend_readex_config.sh .
