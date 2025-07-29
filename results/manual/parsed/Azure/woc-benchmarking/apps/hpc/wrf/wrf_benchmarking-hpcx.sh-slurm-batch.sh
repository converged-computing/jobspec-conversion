#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Azure/woc-benchmarking/apps/hpc/wrf/wrf_benchmarking-hpcx.sh
