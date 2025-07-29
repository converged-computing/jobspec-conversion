#!/bin/bash
#SBATCH --account=p_readex
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=62000
#SBATCH --time=00:30:00

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
