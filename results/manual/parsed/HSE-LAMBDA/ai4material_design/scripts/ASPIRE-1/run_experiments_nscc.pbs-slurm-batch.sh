#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/HSE-LAMBDA/ai4material_design/scripts/ASPIRE-1/run_experiments_nscc.pbs
