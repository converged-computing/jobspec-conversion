#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=15G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=cortex_k40

module load cuda
module unload intel
python Development/oc_ica/compare_models.py
