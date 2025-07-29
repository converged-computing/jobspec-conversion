#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=12g

export PYTHONPATH='$(pwd)'

export PYTHONPATH="$(pwd)"
python src/translate.py \
  --model_dir $1 \
  --test_src_file $2 \
  --test_trg_file $3 \
  --out_file $4 \
  --beam_size 1 \
  --cuda \
