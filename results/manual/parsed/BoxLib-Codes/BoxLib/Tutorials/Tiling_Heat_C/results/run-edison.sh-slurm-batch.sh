#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/BoxLib-Codes/BoxLib/Tutorials/Tiling_Heat_C/results/run-edison.sh
