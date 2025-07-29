#!/bin/bash
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=62000
#SBATCH --time=00:30:00

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
