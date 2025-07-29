#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GeorgeGayno-NOAA/global-workflow/driver/product/run_JGFS_NCEPPOST
