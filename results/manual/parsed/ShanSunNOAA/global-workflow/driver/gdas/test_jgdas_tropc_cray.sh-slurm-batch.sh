#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ShanSunNOAA/global-workflow/driver/gdas/test_jgdas_tropc_cray.sh
