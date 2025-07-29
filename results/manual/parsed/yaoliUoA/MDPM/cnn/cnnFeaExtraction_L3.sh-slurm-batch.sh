#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/yaoliUoA/MDPM/cnn/cnnFeaExtraction_L3.sh
