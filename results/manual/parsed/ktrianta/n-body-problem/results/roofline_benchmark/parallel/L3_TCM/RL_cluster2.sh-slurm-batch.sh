#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ktrianta/n-body-problem/results/roofline_benchmark/parallel/L3_TCM/RL_cluster2.sh
