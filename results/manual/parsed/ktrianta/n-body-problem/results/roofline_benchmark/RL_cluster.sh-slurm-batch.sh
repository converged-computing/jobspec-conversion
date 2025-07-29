#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ktrianta/n-body-problem/results/roofline_benchmark/RL_cluster.sh
