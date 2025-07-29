#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=20480
#SBATCH --time=03:00:00
#SBATCH --partition=general
#SBATCH --qos=medium

/usr/bin/nvidia-smi -L
/usr/bin/scontrol show job -d "$SLURM_JOB_ID"
module use /opt/insy/modulefiles
module load cuda/11.5 cudnn/11.5-8.3.0.98
source /home/nfs/arkhan/venv0/bin/activate
srun python eletcr_ep2.py
