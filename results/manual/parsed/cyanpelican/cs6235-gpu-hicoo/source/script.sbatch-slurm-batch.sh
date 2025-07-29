#!/bin/bash
#SBATCH --job-name=gpu-hicoo
#SBATCH --account=soc-gpu-kp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=60G
#SBATCH --time=00:30:00
#SBATCH --qos=soc-gpu-kp
#SBATCH --constraint=ntasks-per-node=1

ulimit -c unlimited -s
nvidia-smi
echo VISIBLE === $CUDA_VISIBLE_DEVICES
./HiCooExperiment        8
./HiCooExperiment 1024   8 dense-32x32x32
./HiCooExperiment 32     8 datasets/nell-1.tns NOCPU
echo TESTS COMPLETED
