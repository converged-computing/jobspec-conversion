#!/bin/bash
#SBATCH --job-name=cs1430_final_train
#SBATCH --output=cs1430_final_colorizer-%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=96G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=geforce3090

module load python/3.9.0
module load cuda
source ~/Projects/cs1430/cs1430_env/bin/activate
python run.py
