#!/bin/bash
#SBATCH --job-name=sweep_small
#SBATCH --output=%N.%J.VAE_test_loader.out
#SBATCH --error=%N.%J.VAE_test_loader.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:quadro:1
#SBATCH --mem=16g
#SBATCH --time=1-00:00:00

export PATH='$HOME/miniconda_envs/anaconda3/envs/GrooveTransformer:$PATH'
export WANDB_API_KEY='API_KEY'

export PATH="$HOME/miniconda_envs/anaconda3/bin:$PATH"
export PATH="$HOME/miniconda_envs/anaconda3/envs/GrooveTransformer:$PATH"
source activate GrooveTransformer
cd GrooveTransformer
export WANDB_API_KEY="API_KEY"
python -m wandb login
wandb agent mmil_vae_g2d/SmallSweeps_MGT_VAE/b339vcez
