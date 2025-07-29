#!/bin/bash
#SBATCH --job-name=finetune
#SBATCH --account=eqb@a100
#SBATCH --output=out/train_all_parent_w_speaker_codes_c_0_latest.out
#SBATCH --error=out/train_all_parent_w_speaker_codes_c_0_latest.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=05:00:00
#SBATCH --constraint=a100,ntasks-per-node=1

export PYTHONPATH='.'

module purge
module load cpuarch/amd
module load python/3.8.2
conda activate /linkhome/rech/genzuo01/uez75lm/.conda/envs/childes-grammaticality
cd $WORK/childes-contingency
export PYTHONPATH=.
set -x
TRANSFORMERS_OFFLINE=1
model=microsoft/deberta-v3-large          #microsoft/deberta-v3-base    # babylm/roberta-base-strict    #gpt2   #       roberta-large   #cointegrated/roberta-large-cola-krishna2020    #phueb/BabyBERTa-3      #bert-base-uncased
context_length=0
model_type=parent
python -u nn/fine_tuning_nn.py --accelerator gpu --model $model --context-length $context_length --model-type $model_type
