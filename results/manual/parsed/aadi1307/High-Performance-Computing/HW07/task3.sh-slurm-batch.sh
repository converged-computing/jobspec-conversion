#!/bin/bash
#SBATCH --job-name=task3
#SBATCH --output=task3.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=00:10:00

module load nvidia/cuda/11.8.0
g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
./task3
