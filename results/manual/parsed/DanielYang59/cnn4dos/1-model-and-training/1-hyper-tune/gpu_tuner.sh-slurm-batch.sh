#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DanielYang59/cnn4dos/1-model-and-training/1-hyper-tune/gpu_tuner.sh
