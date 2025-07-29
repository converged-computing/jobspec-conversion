#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CUP-ECS/CRS-Alltoall/compile-and-run/lassen-spectrum/bench_alltoall_crs.sh
