#!/bin/bash
#SBATCH --job-name=demo
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=1-12:00:00

source ~/miniconda3/etc/profile.d/conda.sh
conda activate fsd
pip install .
streamlit run demo/app.py --server.fileWatcherType none --server.port 20226
