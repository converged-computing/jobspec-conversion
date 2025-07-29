#!/bin/bash
#SBATCH --job-name=finetune
#SBATCH --account=eqb@a100
#SBATCH --output=out/train_%j.out
#SBATCH --error=out/train_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --constraint=a100,ntasks-per-node=1

module purge
module load cpuarch/amd
module load python
conda activate childes_grammaticality
set -x
TRANSFORMERS_OFFLINE=1
model=microsoft/deberta-v3-large #roberta-base microsoft/deberta-v3-large	#microsoft/deberta-v3-base	# babylm/roberta-base-strict	#gpt2	#	roberta-large	#cointegrated/roberta-large-cola-krishna2020	#phueb/BabyBERTa-3	#bert-base-uncased
context_length=8
train_data_size=0.4
batch_size=50
accumulate=2
python -u grammaticality_annotation/fine_tune_grammaticality_nn.py --accelerator gpu --model $model --context-length $context_length --batch-size $batch_size --accumulate_grad_batches $accumulate --train-data-size $train_data_size #--num-cv-folds 2
