#!/bin/bash
#SBATCH --job-name=param-sweep
#SBATCH --output=jobs/sweep_%A_%a.stdout
#SBATCH --error=jobs/sweep_%A_%a.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a6000:2
#SBATCH --time=08:00:00

cd $SLURM_SUBMIT_DIR
echo "JOB timestamp: $(date)"
echo "JOB ID: $SLURM_JOB_ID"
hostname
source ~/.bashrc
nvidia-smi -L
conda activate usb2
python --version
which python
sweep_id=kxh8r98c
srun --exclusive --gres=gpu:2 -l wandb agent koffi-anderson/usb_experiments/${sweep_id}
