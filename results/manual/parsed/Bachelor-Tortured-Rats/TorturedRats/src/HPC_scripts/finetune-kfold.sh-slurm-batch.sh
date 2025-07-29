#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Bachelor-Tortured-Rats/TorturedRats/src/HPC_scripts/finetune-kfold.sh
