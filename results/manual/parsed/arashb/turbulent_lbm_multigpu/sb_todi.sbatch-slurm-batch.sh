#!/bin/bash
#SBATCH --job-name=multigpu_lbm
#SBATCH --nodes=256
#SBATCH --ntasks=256
#SBATCH --cpus-per-task=1
#SBATCH --time=11:00:00
#SBATCH --constraint=ntasks-per-node=1

NGPUs=256
NEXPs=2
./benchmark.py $NGPUs $NEXPs aprun ./build/lbm_opencl_dc_CC_release weak
mkdir -p ./output/results_benchmark/todi/weak/1d/basic/
mkdir -p ./output/benchmark/
mv -f ./output/benchmark/*.ini ./output/results_benchmark/todi/weak/1d/basic/
mv -f ./output/benchmark/*.txt ./output/results_benchmark/todi/weak/1d/basic/
mv -f ./output/benchmark/*.out ./output/results_benchmark/todi/weak/1d/basic/
