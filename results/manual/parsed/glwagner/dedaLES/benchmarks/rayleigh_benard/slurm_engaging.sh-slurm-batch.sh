#!/bin/bash
#SBATCH --job-name=kerr1-CS
#SBATCH --output=job_%j.out
#SBATCH --error=job_%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3500
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=16

. /home/glwagner/software/miniconda3/etc/profile.d/conda.sh
conda activate dedalus
run="1"
closure="ConstantSmagorinsky"
mpiexec python3 rayleigh_benard_kerr.py $run $closure >> kerr_CS_$run.out
