#!/bin/bash
#SBATCH --job-name=diffusion-policy-can_ph-crossway_vit-t_backbone
#SBATCH --output=./slurm_jobs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:A100:1
#SBATCH --mem=64GB
#SBATCH --time=3-00:00:00

module load anaconda3
module load cuda
module list
conda init bash
source ~/.bashrc
conda activate robo
echo Active env: $CONDA_DEFAULT_ENV
echo $(nvidia-smi)
echo started running script
EGL_DEVICE_ID=0 python /users/dreilly1/Projects/robotics/crossway_diffusion/train.py --config-dir=config/can_ph/ --config-name=typea.yaml training.seed=42
echo finished running script
