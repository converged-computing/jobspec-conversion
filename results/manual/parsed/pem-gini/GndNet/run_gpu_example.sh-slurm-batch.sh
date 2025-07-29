#!/bin/bash
#SBATCH --job-name=gpu_serial
#SBATCH --output=gpu_serial.%J.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load CUDA
echo; export; echo; nvidia-smi; echo
$CUDA_ROOT/extras/demo_suite/deviceQuery -noprompt
