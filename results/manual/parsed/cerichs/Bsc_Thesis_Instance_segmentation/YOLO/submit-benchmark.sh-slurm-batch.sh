#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/cerichs/Bsc_Thesis_Instance_segmentation/YOLO/submit-benchmark.sh
