#!/bin/bash
#SBATCH --job-name=qed
#SBATCH --account=rlmolecule
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=36
#SBATCH --gres=gpu:2
#SBATCH --time=01:00:00

module load cudnn/8.1.1/cuda-11.2
conda activate graphenv
python run_qed.py
