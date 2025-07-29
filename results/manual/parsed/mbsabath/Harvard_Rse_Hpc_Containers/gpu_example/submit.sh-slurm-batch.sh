#!/bin/bash
#SBATCH --job-name=gpu_example
#SBATCH --output=gpu_example.out
#SBATCH --error=gpu_example.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4000
#SBATCH --time=00:30:00
#SBATCH --partition=gpu_test
#SBATCH --constraint=ntasks-per-node=1

singularity run --nv tensorflow_latest-gpu.sif python -c 'from tensorflow.python.client import device_lib; print(device_lib.list_local_devices())'
