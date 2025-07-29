#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ezrafielding/GalaxyClassification/jobs/DECaLS_train_resnet.sh
