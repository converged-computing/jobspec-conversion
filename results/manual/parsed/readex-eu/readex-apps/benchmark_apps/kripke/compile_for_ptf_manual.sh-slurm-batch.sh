#!/bin/bash
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=62000
#SBATCH --time=00:30:00

export CXX='scorep --online-access --user --mpp=mpi --thread=none --nomemory --nocompiler $READEX_CXX'

. readex_env/set_env_ptf.source
. scripts_$READEX_MACHINE/environment.sh
cp CMakeLists-SCOREP-MANUAL.txt CMakeLists.txt
export CXX="scorep --online-access --user --mpp=mpi --thread=none --nomemory --nocompiler $READEX_CXX"
rm -rf build
mkdir build
cd build
cmake ..
make
cp ../scripts_$READEX_MACHINE/run_ptf.sh .
cp ../scripts_$READEX_MACHINE/run_rrl.sh .
