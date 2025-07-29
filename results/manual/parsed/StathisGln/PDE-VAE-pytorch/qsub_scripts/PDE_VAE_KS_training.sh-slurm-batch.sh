#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/StathisGln/PDE-VAE-pytorch/qsub_scripts/PDE_VAE_KS_training.sh
