#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/chingshanchou/UQ-Yeast-Mating-Model/PDE%20sampling/my_script_matlab.sh
