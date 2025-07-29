#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Animadversio/ActMax-Optimizer-Dev/scripts/ng_optim_benchmark.sh
