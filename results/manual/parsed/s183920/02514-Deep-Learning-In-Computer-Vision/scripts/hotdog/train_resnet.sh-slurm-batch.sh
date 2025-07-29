#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/s183920/02514-Deep-Learning-In-Computer-Vision/scripts/hotdog/train_resnet.sh
