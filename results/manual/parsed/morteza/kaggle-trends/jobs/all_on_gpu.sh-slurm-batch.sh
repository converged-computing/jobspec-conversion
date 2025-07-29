#!/bin/bash
#SBATCH --job-name=all_on_gpu
#SBATCH --output=logs/all_on_gpu_%j.log
#SBATCH --mail-user=morteza.ansarinia@uni.lu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1gb
#SBATCH --time=00:01:00

. /etc/profile.d/lmod.sh
conda env create -f environment.yml
conda activate kaggle-trends
python workspace/kaggle-trends/src/automl_loading.py
