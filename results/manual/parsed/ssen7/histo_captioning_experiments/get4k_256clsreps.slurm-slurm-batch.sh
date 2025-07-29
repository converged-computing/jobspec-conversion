#!/bin/bash
#SBATCH --account=gutintelligencelab
#SBATCH --output=get_4kreps.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:2
#SBATCH --time=1-00:00:00
#SBATCH --partition=bii-gpu

module load singularity pytorch/1.10.0
singularity run --nv $CONTAINERDIR/pytorch-1.10.0.sif /home/ss4yd/vision_transformer/captioning_vision_transformer/generate4k_256clsreps.py
