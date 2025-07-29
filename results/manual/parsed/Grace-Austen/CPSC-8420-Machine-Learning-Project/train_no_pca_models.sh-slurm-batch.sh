#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Grace-Austen/CPSC-8420-Machine-Learning-Project/train_no_pca_models.sh
