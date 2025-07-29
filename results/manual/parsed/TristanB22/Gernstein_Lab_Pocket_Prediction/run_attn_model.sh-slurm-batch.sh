#!/bin/bash
#SBATCH --job-name=attn_pocket_prediction
#SBATCH --output=attn_pocket_pred_out.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=2
#SBATCH --time=20:00:00

python -m pip install --upgrade pip
module purge
module load PyTorch
module load CUDA/12.1.1
pip install tqdm
pip install matplotlib
pip install torchviz
python3 train_model.py
