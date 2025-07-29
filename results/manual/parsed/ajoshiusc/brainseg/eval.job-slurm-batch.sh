#!/bin/bash
#SBATCH --account=ajoshi_27
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=64GB
#SBATCH --time=01:00:00

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
python /scratch1/wenhuicu/brainseg/evaluation.py --name='BCE0.0001weighted_BCE2'
