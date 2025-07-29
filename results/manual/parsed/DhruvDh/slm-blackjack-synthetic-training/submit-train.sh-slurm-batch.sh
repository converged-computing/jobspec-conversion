#!/bin/bash
#SBATCH --job-name=train-2048-mamba
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:A40:1
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --partition=GPU
#SBATCH --constraint=ntasks-per-node=1

module load singularity
singularity exec --nv nvidia.sif bash -c "$(cat $JOB_NAME.sh)"
