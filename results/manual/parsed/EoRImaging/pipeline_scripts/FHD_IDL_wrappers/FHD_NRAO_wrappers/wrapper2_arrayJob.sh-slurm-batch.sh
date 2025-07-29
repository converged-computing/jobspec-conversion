#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/EoRImaging/pipeline_scripts/FHD_IDL_wrappers/FHD_NRAO_wrappers/wrapper2_arrayJob.sh
