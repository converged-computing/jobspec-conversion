#!/usr/bin/zsh

#SBATCH -J gpu_serial
#SBATCH -p devel
#SBATCH -o gpu_serial.%J.log
#SBATCH --gres=gpu:1

module load CUDA

# Print some debug information
echo; export; echo; nvidia-smi; echo

$CUDA_ROOT/extras/demo_suite/deviceQuery -noprompt