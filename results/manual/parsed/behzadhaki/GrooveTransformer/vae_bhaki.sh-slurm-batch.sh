#!/bin/bash
#SBATCH --job-name=sweep_small
#SBATCH --output=%N.%J.VAE_test_loader.out
#SBATCH --error=%N.%J.VAE_test_loader.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:tesla:1
#SBATCH --mem=16g
#SBATCH --time=08:00:00
#SBATCH --partition=medium

export PATH='$HOME/.conda/envs/GrooveTransformer/bin:$PATH'
export WANDB_API_KEY='API_KEY'

source /etc/profile.d/lmod.sh
source /etc/profile.d/zz_hpcnow-arch.sh
module load Anaconda3/2020.02
export PATH="/soft/easybuild/x86_64/software/Anaconda3/2020.02/bin:$PATH"
export PATH="$HOME/.conda/envs/GrooveTransformer/bin:$PATH"
source /soft/easybuild/x86_64/software/Anaconda3/2020.02/etc/profile.d/conda.sh
conda activate GrooveTransformer
export WANDB_API_KEY=API_KEY
python -m wandb login
cd GrooveTransformer
python train.py
