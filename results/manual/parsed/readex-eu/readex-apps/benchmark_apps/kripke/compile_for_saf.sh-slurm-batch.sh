#!/bin/bash
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=2500M
#SBATCH --time=00:30:00

export CXX='scorep --nomemory $READEX_CXX'

. readex_env/set_env_saf.source
. scripts_$READEX_MACHINE/environment.sh
cp CMakeLists-PLAIN.txt CMakeLists.txt	#without any manualy inserted region
export CXX="scorep --nomemory $READEX_CXX"
rm -rf build
mkdir build
cd build
cmake ..
make
cp ../scripts_$READEX_MACHINE/do_scorep_autofilter_single.sh .
cp ../scripts_$READEX_MACHINE/run_saf.sh .
