#!/bin/bash
#SBATCH --job-name=PB-UQ-train
#SBATCH --account=gpu
#SBATCH --output=job.sh.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=5-00:00:00
#SBATCH --exclude=c004,c011,c013

export JAX_ENABLE_X64='True'

export JAX_ENABLE_X64=True
python train.py
