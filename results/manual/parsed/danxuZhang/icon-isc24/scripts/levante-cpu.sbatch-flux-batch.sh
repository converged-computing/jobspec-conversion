#!/bin/bash
#FLUX: --job-name=scc
#FLUX: --queue=compute
#FLUX: -t=600
#FLUX: --priority=16

ulimit -s unlimited
ulimit -c 0
COMPILER='gnu' 
FLAGS="" 
FORCE_CLEAN=true
FILE=$(pwd)/tasks/input.nc
. scripts/levante-setup.sh $COMPILER cpu
. scripts/build.sh "build" "-DMU_IMPL=seq -DCMAKE_CXX_FLAGS=$FLAGS" $FORCE_CLEAN
./build/bin/graupel $FILE
