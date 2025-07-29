#!/bin/bash
#SBATCH --job-name=M1_build
#SBATCH --output=./stdout/M1_build.o%j.out
#SBATCH --error=./stdout/M1_build.e%j.error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00

START=$(date)
echo "Started running at $START."
unset DISPLAY
python build_network.py #srun
END=$(date)
echo "Done running simulation at $END"
