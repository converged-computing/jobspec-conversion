#!/bin/bash
#SBATCH --account=$ACCOUNT
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=10:00:00

module load anaconda
module load cuda/11.6.0
conda activate PerceptAlign
streamlit run --server.port 5554 --server.address 0.0.0.0 ./sample_visualization.py
