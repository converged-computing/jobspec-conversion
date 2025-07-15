#!/bin/bash
#FLUX: --job-name=joyous-punk-9420
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
ml VTune Advisor intel-compilers/2022.1.0 CMake/3.23.1-GCCcore-11.3.0
[ -d build_advisor ] && rm -rf build_advisor
[ -d build_advisor ] || mkdir build_advisor
cd build_advisor
CC=icc CXX=icpc cmake ..
make
for calc in "ref" "batch" "line"; do
    rm -rf Advisor-$calc
    mkdir Advisor-$calc
    # Basic survey
    advixe-cl -collect survey -project-dir Advisor-$calc  -- ./mandelbrot -c $calc -s 4096
    # Roof line
    advixe-cl -collect tripcounts -flop -project-dir Advisor-$calc  -- ./mandelbrot -c $calc -s 4096
done
