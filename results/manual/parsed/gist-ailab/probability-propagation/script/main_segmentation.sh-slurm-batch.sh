#!/bin/bash
#SBATCH --job-name=seg
#SBATCH --output=slurm_logs/%x.%3a.%A.out
#SBATCH --error=slurm_logs/%x.%3a.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=8
#SBATCH --time=10:00:00
#SBATCH --array=0

[ ! -d "slurm_logs" ] && echo "Create a directory slurm_logs" && mkdir -p slurm_logs
module load cuda/11.1.1
module load gcc
echo "===> Anaconda env loaded"
source ~/.bashrc
source activate openpoints
nvidia-smi
nvcc --version
hostname
NUM_GPU_AVAILABLE=`nvidia-smi --query-gpu=name --format=csv,noheader | wc -l`
echo $NUM_GPU_AVAILABLE
cfg=$1
PY_ARGS=${@:2}
python examples/segmentation/main.py --cfg $cfg ${PY_ARGS}
