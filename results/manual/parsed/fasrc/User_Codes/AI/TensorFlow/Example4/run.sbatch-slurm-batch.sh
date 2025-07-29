#!/bin/bash
#SBATCH --job-name=tf_test
#SBATCH --output=tf_test.out
#SBATCH --error=tf_test.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=8G
#SBATCH --time=00:30:00
#SBATCH --partition=gpu

srun -c $SLURM_CPUS_PER_TASK singularity pull --disable-cache docker://tensorflow/tensorflow:latest-gpu
singularity exec --nv tensorflow_latest-gpu.sif python tf_test_multi_gpu.py
