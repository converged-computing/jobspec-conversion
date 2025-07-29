#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ACANETS/eece-6540-labs/Labs/lab2/matrix-multi/S10_oneapi_batch-fpga-profile.sh
