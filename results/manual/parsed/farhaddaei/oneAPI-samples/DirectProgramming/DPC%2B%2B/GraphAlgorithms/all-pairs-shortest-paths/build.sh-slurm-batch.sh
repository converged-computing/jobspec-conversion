#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/farhaddaei/oneAPI-samples/DirectProgramming/DPC%2B%2B/GraphAlgorithms/all-pairs-shortest-paths/build.sh
