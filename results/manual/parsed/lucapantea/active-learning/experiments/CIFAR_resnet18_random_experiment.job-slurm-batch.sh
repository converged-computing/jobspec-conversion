#!/bin/bash
#SBATCH --job-name=CIFAR10_resnet18_random_experiment
#SBATCH --output=../out/slurm_output_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --time=2-00:00:00

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
               --strategy random \
               --dataset cifar10 \
               --model resnet18 \
               --epochs 100 \
               --n_round 100 \
               --num_valid $num_valid_realistic \
               --n_init_labeled $n_init_labeled_realistic \
               --n_query $n_query_realistic
