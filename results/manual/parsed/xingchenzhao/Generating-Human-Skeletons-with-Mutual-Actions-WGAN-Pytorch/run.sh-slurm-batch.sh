#!/bin/bash
#SBATCH --job-name=run_gan
#SBATCH --mail-user=zig9@pitt.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12000
#SBATCH --time=05:00:00
#SBATCH --partition=gtx1080
#SBATCH --constraint=ntasks-per-node=1

module purge #make sure the modules environment is sane
module load python/3.7.0 cuda/10.1 venv/wrap
workon pytorch
python vae0_train.py > vae_result.txt
python gan0_train.py > gan_result.txt
