#!/bin/bash
#SBATCH --job-name=scc
#SBATCH --account=ka1273
#SBATCH --output=%x.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=compute

ulimit -s unlimited
ulimit -c 0
COMPILER='gnu' 
FLAGS="" 
FORCE_CLEAN=true
FILE=$(pwd)/tasks/input.nc
. scripts/levante-setup.sh $COMPILER cpu
. scripts/build.sh "build" "-DMU_IMPL=seq -DCMAKE_CXX_FLAGS=$FLAGS" $FORCE_CLEAN
./build/bin/graupel $FILE
