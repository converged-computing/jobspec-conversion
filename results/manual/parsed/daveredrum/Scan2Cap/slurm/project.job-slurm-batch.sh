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

date;hostname;pwd
python scripts/project_multiview_features.py --maxpool
