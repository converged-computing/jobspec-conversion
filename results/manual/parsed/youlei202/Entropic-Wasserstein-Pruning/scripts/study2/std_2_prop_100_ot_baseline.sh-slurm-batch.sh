#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/youlei202/Entropic-Wasserstein-Pruning/scripts/study2/std_2_prop_100_ot_baseline.sh
