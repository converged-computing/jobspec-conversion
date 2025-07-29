#!/bin/bash
#SBATCH --job-name=XAIATTACK-MNLIMatched
#SBATCH --output=../logs/cluster/%x.out.%A_%a
#SBATCH --error=../logs/cluster/%x.err.%A_%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=32000
#SBATCH --time=1-00:00:00

export DATASET='mnli_matched'
export MODEL='distilbert-base-uncased'

module purge
module load gcc
module load python
module load cuda
module load cuDNN
nvidia-smi
cd ..
export DATASET="mnli_matched"
export MODEL="distilbert-base-uncased"
srun python src/main.py --dataset $DATASET --model $MODEL --wandb_logging
srun python src/adversarial_testing.py --dataset $DATASET --model $MODEL --wandb_logging
srun python src/adversarial_transfer.py --dataset $DATASET --basemodel $MODEL --transfermodel distilbert-base-uncased --wandb_logging
srun python src/adversarial_transfer.py --dataset $DATASET --basemodel $MODEL --transfermodel bert-base-uncased --wandb_logging
srun python src/adversarial_transfer.py --dataset $DATASET --basemodel $MODEL --transfermodel roberta-base --wandb_logging
