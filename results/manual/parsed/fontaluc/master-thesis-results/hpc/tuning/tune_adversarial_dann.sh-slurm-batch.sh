#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/fontaluc/master-thesis-results/hpc/tuning/tune_adversarial_dann.sh
