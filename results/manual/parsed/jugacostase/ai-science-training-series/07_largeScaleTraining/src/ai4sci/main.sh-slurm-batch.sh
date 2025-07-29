#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jugacostase/ai-science-training-series/07_largeScaleTraining/src/ai4sci/main.sh
