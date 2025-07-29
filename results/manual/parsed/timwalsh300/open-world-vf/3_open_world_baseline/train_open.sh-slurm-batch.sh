#!/bin/bash
#SBATCH --job-name=train_open_dschuster16_tor
#SBATCH --output=/home/timothy.walsh/VF/3_open_world_baseline/%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:rtx6000:1
#SBATCH --mem=64GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=barton

source /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/bin/activate /share/spack/gcc-7.2.0/miniconda3-4.5.12-gkh/envs/tflow
python3 /home/timothy.walsh/VF/3_open_world_baseline/train_open.py
