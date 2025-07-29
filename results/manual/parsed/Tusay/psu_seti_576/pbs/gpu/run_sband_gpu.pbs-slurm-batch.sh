#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Tusay/psu_seti_576/pbs/gpu/run_sband_gpu.pbs
