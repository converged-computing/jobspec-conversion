#!/bin/bash
#SBATCH --job-name=coNGN
#SBATCH --output=slurm_%j.output
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=64gb
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu_4

export LD_LIBRARY_PATH='/opt/bwhpc/common/devel/cuda/11.8/extras/CUPTI/lib64/:$LD_LIBRARY_PATH'
export XLA_FLAGS='--xla_gpu_cuda_data_dir=/opt/bwhpc/common/devel/cuda/11.8/'

ulimit -s unlimited
eval "$(conda shell.bash hook)"
echo $CONDA_PREFIX
conda activate leaderboard
echo $CONDA_PREFIX
module load devel/cuda/11.8
export LD_LIBRARY_PATH=/opt/bwhpc/common/devel/cuda/11.8/extras/CUPTI/lib64/:$LD_LIBRARY_PATH
export XLA_FLAGS=--xla_gpu_cuda_data_dir=/opt/bwhpc/common/devel/cuda/11.8/
nvidia-smi
echo $LD_LIBRARY_PATH
python3 run.py
