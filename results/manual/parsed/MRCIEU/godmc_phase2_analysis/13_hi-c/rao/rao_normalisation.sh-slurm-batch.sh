#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MRCIEU/godmc_phase2_analysis/13_hi-c/rao/rao_normalisation.sh
