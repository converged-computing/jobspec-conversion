#!/bin/bash
#SBATCH --job-name=pre_lstm
#SBATCH --account=eqb@a100
#SBATCH --output=out/pretrain_%j.out
#SBATCH --error=out/pretrain_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --constraint=a100,ntasks-per-node=1

export TRANSFORMERS_OFFLINE='1'
export TOKENIZERS_PARALLELISM='false'

module purge
module load cpuarch/amd
module load python
conda activate childes_grammaticality
set -x
export TRANSFORMERS_OFFLINE=1
export TOKENIZERS_PARALLELISM=false
python -u grammaticality_annotation/pretrain_lstm.py --learning-rate 1e-3
