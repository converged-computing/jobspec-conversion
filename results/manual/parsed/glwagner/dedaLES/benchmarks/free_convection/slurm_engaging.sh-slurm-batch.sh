#!/bin/bash
#SBATCH --job-name=merge
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3500
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
analysis="freeconvection_nh64_nz64_Q1_bfreq22891_DNS"
mpiexec python3 merge.py $analysis
