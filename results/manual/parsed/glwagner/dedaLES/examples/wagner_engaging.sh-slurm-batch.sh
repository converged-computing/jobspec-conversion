#!/bin/bash
#SBATCH --job-name=FC0
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=04:00:00
#SBATCH --qos=plenum
#SBATCH --constraint=ntasks-per-node=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
mpiexec python3 free_convection_example.py >> FC0.out
