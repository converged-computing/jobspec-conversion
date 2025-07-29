#!/bin/bash
#SBATCH --job-name=upwindAcc2_p100
#SBATCH --output=upwindAcc2_p100-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=01:00:00

exe="@CMAKE_BINARY_DIR@/upwind/cxx/upwindAcc2Cxx"
time srun $exe -numCells 800 -numSteps 10
