#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ARCHER-CSE/parallel-io/benchmark/IOR/DiRAC-IOR/run/run_32.pbs
