#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=/rhome/dchen/Pointnet2.ScanNet/logs/%j.log
#SBATCH --mail-user=zhenyu.chen@tum.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=rtx_3090:1
#SBATCH --mem=100gb
#SBATCH --partition=normal

date;hostname;pwd
python scripts/train.py --use_multiview --use_normal --tag ssg
