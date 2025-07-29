#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/argonne-lcf/ATPESC_MachineLearning/02_dataPipelines/00_tensorflowDatasetAPI/submit_polaris.sh
