#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/btlorch/gaussian-processes-for-camera-model-identification/experiments/torque/train_single_gpc_woody.sh
