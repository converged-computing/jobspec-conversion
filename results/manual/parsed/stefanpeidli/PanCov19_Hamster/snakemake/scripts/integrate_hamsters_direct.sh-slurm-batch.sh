#!/bin/bash
#SBATCH --job-name=gpu_test
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60G
#SBATCH --time=23:00:00
#SBATCH --partition=gpu-el8
#SBATCH --exclude=gpu[38-39]

python integrate_hamsters_direct.py
echo "Done"
