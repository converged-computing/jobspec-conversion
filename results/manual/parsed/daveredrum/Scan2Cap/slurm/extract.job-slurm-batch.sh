#!/bin/bash
#SBATCH --job-name=prep
#SBATCH --output=/rhome/dchen/Scan2CapRelease/logs/%j.log
#SBATCH --mail-user=zhenyu.chen@tum.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=rtx_2080:1
#SBATCH --mem=60gb
#SBATCH --partition=normal

date;hostname;pwd
python scripts/compute_multiview_features.py
