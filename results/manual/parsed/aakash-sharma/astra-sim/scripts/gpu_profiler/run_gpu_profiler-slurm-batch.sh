#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/aakash-sharma/astra-sim/scripts/gpu_profiler/run_gpu_profiler
