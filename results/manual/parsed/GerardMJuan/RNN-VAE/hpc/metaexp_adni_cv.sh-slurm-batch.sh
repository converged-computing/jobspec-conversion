#!/bin/bash
#SBATCH --job-name=vae_cv
#SBATCH --output=LOGS/vaecv_%J.out
#SBATCH --error=LOGS/vaecv_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --chdir=/homedtic/gmarti/CODE/RNN-VAE

source /etc/profile.d/lmod.sh
source /etc/profile.d/easybuild.sh
module load Python
module --ignore-cache load CUDA/10.2.89
module --ignore-cache load cuDNN/7.6.5.32-CUDA-10.2.89
source /homedtic/gmarti/pytorch/bin/activate 
python scripts_mc_moreparams/train_adni_full.py
