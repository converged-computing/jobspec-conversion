#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zarzycki/ncl-zarzycki/projects/ASD/AR-tracking/batch-process.sh
