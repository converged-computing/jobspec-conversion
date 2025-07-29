#!/bin/bash
#SBATCH --job-name=wandb-sweep
#SBATCH --output=jobs/sweep_%A_%a.stdout
#SBATCH --error=jobs/sweep_%A_%a.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titanrtx:2
#SBATCH --time=12:00:00
#SBATCH --partition=gpu-8

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
conda activate usb2
python --version
which python
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
nvidia-smi -L
sweep_id="dpgkapyt"
wandb agent koffi-anderson/usb_side_channel/${sweep_id}
