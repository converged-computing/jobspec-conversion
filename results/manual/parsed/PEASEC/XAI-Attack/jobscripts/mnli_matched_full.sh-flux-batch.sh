#!/bin/bash
#FLUX: --job-name=confused-eagle-3078
#FLUX: --urgency=16

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
