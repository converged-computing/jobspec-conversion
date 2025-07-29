#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/amakarewicz/2022-DTU-Deep-Learning-Speech-Synthesis/experiments/HPC_scripts/train_gpuv100.sh
