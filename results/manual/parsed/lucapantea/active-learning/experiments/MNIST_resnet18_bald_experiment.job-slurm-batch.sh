#!/bin/bash
#FLUX: --job-name=MNIST_resnet18_bald_experiment
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load 2022
module load Anaconda3/2022.05
source ../.env
source activate $PROJECT_ENV_NAME
cd $PROJECT_DIR
wandb online
n_init_labeled_realistic=100
num_valid_realistic=300
n_query_realistic=10
python main.py --experiment \
               --debug \
               --strategy bald \
               --dataset mnist \
               --model resnet18 \
               --epochs 100 \
               --n_round 100 \
               --num_valid $num_valid_realistic \
               --n_init_labeled $n_init_labeled_realistic \
               --n_query $n_query_realistic
