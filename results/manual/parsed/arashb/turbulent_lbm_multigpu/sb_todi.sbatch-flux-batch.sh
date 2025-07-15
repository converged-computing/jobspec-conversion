#!/bin/bash
#FLUX: --job-name="multigpu_lbm"
#FLUX: -N=256
#FLUX: -n=256
#FLUX: -t=39600
#FLUX: --priority=16

NGPUs=256
NEXPs=2
./benchmark.py $NGPUs $NEXPs aprun ./build/lbm_opencl_dc_CC_release weak
mkdir -p ./output/results_benchmark/todi/weak/1d/basic/
mkdir -p ./output/benchmark/
mv -f ./output/benchmark/*.ini ./output/results_benchmark/todi/weak/1d/basic/
mv -f ./output/benchmark/*.txt ./output/results_benchmark/todi/weak/1d/basic/
mv -f ./output/benchmark/*.out ./output/results_benchmark/todi/weak/1d/basic/
