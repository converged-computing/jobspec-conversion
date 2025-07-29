#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/apmizzi/DART_Chem/apm_run_scripts/RUN_OMI_TEST/real_time_OMI_v3.6.1_add_emiss.ksh
