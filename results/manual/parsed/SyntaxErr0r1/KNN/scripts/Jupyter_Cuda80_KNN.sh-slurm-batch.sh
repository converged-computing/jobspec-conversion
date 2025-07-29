#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SyntaxErr0r1/KNN/scripts/Jupyter_Cuda80_KNN.sh
