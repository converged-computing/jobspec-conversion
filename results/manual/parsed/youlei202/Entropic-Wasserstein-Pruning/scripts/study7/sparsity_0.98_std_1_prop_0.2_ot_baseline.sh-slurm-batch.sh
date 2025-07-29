#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/youlei202/Entropic-Wasserstein-Pruning/scripts/study7/sparsity_0.98_std_1_prop_0.2_ot_baseline.sh
