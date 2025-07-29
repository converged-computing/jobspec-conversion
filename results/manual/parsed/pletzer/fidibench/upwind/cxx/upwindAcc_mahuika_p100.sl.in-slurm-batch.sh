#!/bin/bash
#SBATCH --job-name=upwindAcc_p100
#SBATCH --output=upwindAcc_p100-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4096
#SBATCH --time=01:00:00

exe="@CMAKE_BINARY_DIR@/upwind/cxx/upwindAccCxx"
time srun $exe -numCells 1024 -numSteps 10
