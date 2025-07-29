#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NCAR/AVHRR_SST_to_CESM/gen_atm_ocn_maps/regridbatch.bluefire.sh
