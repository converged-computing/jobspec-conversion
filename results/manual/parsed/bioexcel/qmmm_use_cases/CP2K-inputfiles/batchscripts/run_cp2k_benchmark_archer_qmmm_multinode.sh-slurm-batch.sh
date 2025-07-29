#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bioexcel/qmmm_use_cases/CP2K-inputfiles/batchscripts/run_cp2k_benchmark_archer_qmmm_multinode.sh
