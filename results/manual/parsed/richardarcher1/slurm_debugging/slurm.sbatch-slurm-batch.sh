#!/bin/bash
#SBATCH --job-name=nvidia
#SBATCH --output=output.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:3
#SBATCH --mem=12GB
#SBATCH --time=1-00:05:00
#SBATCH --partition=gpu

echo "SLURM_JOBID="$SLURM_JOBID
echo " "
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo " "
nvidia-smi
conda activate test_build_2point3
echo "==============================="
conda config --show channels
echo "==============================="
python test.py
