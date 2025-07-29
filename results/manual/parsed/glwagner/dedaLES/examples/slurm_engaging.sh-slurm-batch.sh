#!/bin/bash
#SBATCH --job-name=merge
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
analysis="freeconvection_nx256_ny256_nz256_F0p0000000001_Ninv300_DNS"
mpiexec python3 merge.py $analysis >> merge_$analysis.out
