#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sgalkina/poe-vaes/mmvae_mnist_split/src/hpc_train_split.sh
