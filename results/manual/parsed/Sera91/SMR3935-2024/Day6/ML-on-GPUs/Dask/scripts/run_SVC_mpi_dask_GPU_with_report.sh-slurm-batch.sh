#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Sera91/SMR3935-2024/Day6/ML-on-GPUs/Dask/scripts/run_SVC_mpi_dask_GPU_with_report.sh
