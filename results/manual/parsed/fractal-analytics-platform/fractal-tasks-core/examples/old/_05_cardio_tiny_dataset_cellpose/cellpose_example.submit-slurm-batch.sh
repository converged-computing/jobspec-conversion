#!/bin/bash
#SBATCH --job-name=cp
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60g
#SBATCH --time=01:40:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=1

date
source /opt/easybuild/software/Anaconda3/2019.07/etc/profile.d/conda.sh
conda init bash
conda activate tasks-pip
rm -r tmp_out
python run_example_cellpose.py
date
