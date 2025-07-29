#!/bin/bash
#SBATCH --job-name=Exp
#SBATCH --output=run_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --gres=1
#SBATCH --time=00:15:00
#SBATCH --partition=gpu

export DATA_DIR='./DATA'
export WANDB_DIR='$HOME/CEConvDL2/CEConv/WANDB'
export OUT_DIR='./output'
export WANDB_API_KEY='$YOUR_API_KEY'
export WANDB_NAME='$RUN_NAME_ON_WANDB'

module purge
module load 2022
module load Anaconda3/2022.05
source ~/.bashrc
source activate CEConv
cd $HOME/CEConvDL2/CEConv
export DATA_DIR=./DATA
export WANDB_DIR=$HOME/CEConvDL2/CEConv/WANDB
export OUT_DIR=./output
export WANDB_API_KEY=$YOUR_API_KEY
export WANDB_NAME=$RUN_NAME_ON_WANDB
