#!/bin/bash
#SBATCH --job-name=UQS37
#SBATCH --account=ldr@gpu
#SBATCH --output=omp%j.out
#SBATCH --error=omp%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --time=3-23:59:59
#SBATCH --partition=gpu_p2
#SBATCH --qos=qos_gpu-t4

hostname
echo --------------------------------------
echo --------------------------------------
pwd
echo --------------------------------------
echo --------------------------------------
module purge
module load anaconda-py3
conda activate pytorch
CL_SOCKET_IFNAME=eno1 python train.py --data_dir /gpfsdswork/dataset/MUSDB18/ --ckpdir weights --cfg_path cfg.yaml
