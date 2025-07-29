#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ifgovh/Anomalous-diffusion-dynamics-of-SGD/GPU_train.sh
