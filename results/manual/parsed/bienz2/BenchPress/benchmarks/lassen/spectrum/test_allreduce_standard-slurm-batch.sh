#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/bienz2/BenchPress/benchmarks/lassen/spectrum/test_allreduce_standard
