#!/bin/bash
#SBATCH --job-name=PGPR
#SBATCH --output=PGPR-%j.out
#SBATCH --error=PGPR-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

module load cuda-11.2.1
module load anaconda3
nvidia-smi
conda activate rs_survey
python preprocess.py --dataset cd
python train_transe_model.py --dataset cd
python train_agent.py --dataset cd
python test_agent.py --dataset cd --run_path True --run_eval True
