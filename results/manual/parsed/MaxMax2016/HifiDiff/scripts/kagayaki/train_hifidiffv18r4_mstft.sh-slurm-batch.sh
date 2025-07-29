#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MaxMax2016/HifiDiff/scripts/kagayaki/train_hifidiffv18r4_mstft.sh
