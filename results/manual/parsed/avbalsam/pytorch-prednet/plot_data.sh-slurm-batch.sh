#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=64GB
#SBATCH --time=1-00:00:00
#SBATCH --chdir=/om2/user/avbalsam/prednet/logs
#SBATCH --array=1

cd /om2/user/avbalsam/prednet
hostname
echo "Plot Data"
date "+%y/%m/%d %H:%M:%S"
source /om2/user/jangh/miniconda/etc/profile.d/conda.sh
conda activate openmind
python plot_data.py
