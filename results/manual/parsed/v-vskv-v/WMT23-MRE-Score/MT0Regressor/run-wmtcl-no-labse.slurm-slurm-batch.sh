#!/bin/bash
#SBATCH --job-name=cl-no-labse-train-regressor
#SBATCH --output=./outputs-%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:8
#SBATCH --mem=256GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=intel-gpu
#SBATCH --constraint=ntasks-per-node=1

echo "Starting at `date` on `hostname` at `pwd`"
echo "Job name: $SLURM_JOB_NAME Job ID: $SLURM_JOB_ID"
echo "==============================="
nvidia-smi
echo "==============================="
echo "Using GPUs: $CUDA_VISIBLE_DEVICES"
echo "==============================="
accelerate launch --config_file="8xgpu.yaml" train.py --checkpoint="wmtcl.ckpt" --no-use-labse --save-file-name="mt0-large-wmtcl-no-labse.pth"
