#!/bin/bash
#SBATCH --job-name=PaiNN-training
#SBATCH --output=runner_output.log
#SBATCH --mail-user=xinyang@dtu.dk
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:RTX3090:1
#SBATCH --time=7-00:00:00
#SBATCH --partition=sm3090

export MKL_NUM_THREADS='1'
export NUMEXPR_NUM_THREADS='1'
export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'

export MKL_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
nvidia-smi > gpu_info
ulimit -s unlimited
python3 md_run.py
