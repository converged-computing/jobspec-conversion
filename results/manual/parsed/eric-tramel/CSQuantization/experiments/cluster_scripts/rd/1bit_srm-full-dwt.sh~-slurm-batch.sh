#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/eric-tramel/CSQuantization/experiments/cluster_scripts/rd/1bit_srm-full-dwt.sh~
