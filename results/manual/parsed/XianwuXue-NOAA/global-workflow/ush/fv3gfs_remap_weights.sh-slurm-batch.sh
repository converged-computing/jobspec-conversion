#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/XianwuXue-NOAA/global-workflow/ush/fv3gfs_remap_weights.sh
