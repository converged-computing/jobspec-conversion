#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ytopt-team/autotune/Benchmarks/ECP-Apps/XSBench/Summit/xsbench-mpi/offload-power/runs.lsf
