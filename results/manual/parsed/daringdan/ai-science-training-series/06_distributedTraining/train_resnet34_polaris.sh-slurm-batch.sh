#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/daringdan/ai-science-training-series/06_distributedTraining/train_resnet34_polaris.sh
