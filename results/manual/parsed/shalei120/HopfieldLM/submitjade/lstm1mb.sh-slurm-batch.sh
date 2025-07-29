#!/bin/bash
#SBATCH --job-name=HopfieldLM
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

module load cuda/9.2
echo $CUDA_VISIBLE_DEVICES
nvidia-smi
echo $PWD
python3 main.py -m lstm -b 128  -d 1mb -g 0 > slurm-lstmLM-1mb-$SLURM_JOB_ID.out
