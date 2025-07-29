#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/andersthuesen/ChromaAI/jobscripts/jobscript_train_wide_unet_gan.sh
