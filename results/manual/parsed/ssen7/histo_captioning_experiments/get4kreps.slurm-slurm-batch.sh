#!/bin/bash
#SBATCH --account=gutintelligencelab
#SBATCH --output=get_4kreps.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:2
#SBATCH --time=1-00:00:00

module load singularity pytorch/1.10.0
singularity run --nv $CONTAINERDIR/pytorch-1.10.0.sif generate4kreps.py
