#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NCAR/rechunk_retro_nwm_v21/precip/precip_script_pbs.sh
