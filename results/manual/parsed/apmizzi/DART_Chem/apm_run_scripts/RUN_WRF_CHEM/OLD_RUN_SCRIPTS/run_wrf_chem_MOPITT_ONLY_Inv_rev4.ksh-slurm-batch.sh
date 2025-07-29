#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/apmizzi/DART_Chem/apm_run_scripts/RUN_WRF_CHEM/OLD_RUN_SCRIPTS/run_wrf_chem_MOPITT_ONLY_Inv_rev4.ksh
