#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/apmizzi/DART_Chem/apm_run_scripts/RUN_WRF_CHEM/EXPERIMENT_SCRIPTS/run_Exp1_Ret_DA.ksh
