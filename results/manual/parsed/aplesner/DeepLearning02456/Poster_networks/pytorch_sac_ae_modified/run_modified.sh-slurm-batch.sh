#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/aplesner/DeepLearning02456/Poster_networks/pytorch_sac_ae_modified/run_modified.sh
