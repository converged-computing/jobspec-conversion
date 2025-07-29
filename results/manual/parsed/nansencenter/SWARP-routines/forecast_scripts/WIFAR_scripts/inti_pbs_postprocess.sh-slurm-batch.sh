#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/nansencenter/SWARP-routines/forecast_scripts/WIFAR_scripts/inti_pbs_postprocess.sh
