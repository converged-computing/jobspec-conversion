#!/bin/bash
#SBATCH --job-name=exp_classifier
#SBATCH --account=MSS21024
#SBATCH --output=exp_classifier.o%j
#SBATCH --error=exp_classifier.e%j
#SBATCH --mail-user=carson.l@utexas.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:30:00
#SBATCH --partition=gpu-a100

python /work/07965/clans/ls6/Spring_RASR/rasr/rasr/network/experimental_classifier.py          # Do not use ibrun or any other MPI launcher
