#!/bin/bash
#FLUX: --job-name=Exp
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: -t=900
#FLUX: --priority=16

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
