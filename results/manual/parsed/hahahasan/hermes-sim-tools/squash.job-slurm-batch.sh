#!/bin/bash
#SBATCH --job-name=squash
#SBATCH --account=phys-bout-2019
#SBATCH --output=squash_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200gb
#SBATCH --time=11:11:11

export OMP_NUM_THREADS='1'

echo trying
export OMP_NUM_THREADS=1
python ~/scratch/hermes-sim-tools/x-analysis.py
echo exited
