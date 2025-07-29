#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/youlei202/Entropic-Wasserstein-Pruning/scripts/study1/std_4_prop_05_ot_baseline.sh
