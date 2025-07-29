#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mjirik/piglegsurgery/piglegcv/incision/qsub_mmdetection_custom_dataset_detection.sh
