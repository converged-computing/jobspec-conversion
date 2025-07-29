#!/bin/bash
#SBATCH --account=ds6050
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100
#SBATCH --mem=128G
#SBATCH --time=3-00:00:00
#SBATCH --constraint=a100_80gb

module load singularity tensorflow/2.10.0
singularity run --nv $CONTAINERDIR/tensorflow-2.10.0.sif transformer_age3.py
