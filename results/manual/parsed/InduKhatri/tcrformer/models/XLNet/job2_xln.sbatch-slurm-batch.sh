#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=16384
#SBATCH --time=06:00:00
#SBATCH --partition=general
#SBATCH --qos=medium

/usr/bin/nvidia-smi
/usr/bin/scontrol show job -d "$SLURM_JOB_ID"
module use /opt/insy/modulefiles
module load cuda/11.1 cudnn/11.1-8.0.5.39
source /home/nfs/arkhan/venv0/bin/activate
srun python xlntcr_ep2.py
