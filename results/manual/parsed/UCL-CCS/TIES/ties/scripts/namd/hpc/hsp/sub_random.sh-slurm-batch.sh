#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UCL-CCS/TIES/ties/scripts/namd/hpc/hsp/sub_random.sh
