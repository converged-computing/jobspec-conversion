#!/bin/bash
#SBATCH --job-name=thesis_job
#SBATCH --mail-user=spandreas@ece.auth.gr
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=2-00:00:00
#SBATCH --partition=batch

module load gcc miniconda3
source $CONDA_PROFILE/conda.sh
conda activate thesis
cd ~/thesis
ls
pip install -U -r requirements.txt
python train.py
