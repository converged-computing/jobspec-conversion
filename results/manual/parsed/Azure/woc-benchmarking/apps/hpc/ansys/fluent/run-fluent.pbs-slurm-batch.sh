#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Azure/woc-benchmarking/apps/hpc/ansys/fluent/run-fluent.pbs
