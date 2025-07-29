#!/bin/bash
#SBATCH --job-name=w2
#SBATCH --output=../logs/%x_%u_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16G
#SBATCH --partition=mhigh,mlow
#SBATCH --chdir=/home/grupo06/m5-project

source /home/grupo06/venv/bin/activate
python src/main.py --exp_name resnet_kitti_${SLURM_JOB_ID} --config_file config/resnet_kitti.yml
