#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/kyoheikoyama/TCRPrediction/scripts/dir_kicker/kicker_dev_gpu.sh
