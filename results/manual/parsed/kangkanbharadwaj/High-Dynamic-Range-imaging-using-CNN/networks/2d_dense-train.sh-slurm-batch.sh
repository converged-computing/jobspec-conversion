#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kangkanbharadwaj/High-Dynamic-Range-imaging-using-CNN/networks/2d_dense-train.sh
