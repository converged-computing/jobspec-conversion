#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ACANETS/dpcpp-tutorial/word-count/A10_oneapi_batch-fpga-profile.sh
