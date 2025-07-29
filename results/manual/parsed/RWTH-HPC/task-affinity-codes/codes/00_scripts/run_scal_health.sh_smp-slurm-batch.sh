#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/RWTH-HPC/task-affinity-codes/codes/00_scripts/run_scal_health.sh_smp
