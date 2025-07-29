#!/bin/bash
#SBATCH --job-name=cfg-delay
#SBATCH --output=/home/p/u/puzhao/run_logs/%x-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=36GB
#SBATCH --time=7-00:00:00

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
echo
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; 
python main_cfg_delay.py
echo "finish"
