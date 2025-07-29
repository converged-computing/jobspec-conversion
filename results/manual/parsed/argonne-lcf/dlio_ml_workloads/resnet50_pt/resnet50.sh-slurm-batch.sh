#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/argonne-lcf/dlio_ml_workloads/resnet50_pt/resnet50.sh
