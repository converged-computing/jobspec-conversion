#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/youlei202/distributional-counterfactual-explanation/scripts/cardio_svm.sh
