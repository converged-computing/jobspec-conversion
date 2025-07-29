#!/bin/bash
#SBATCH --job-name=megatron_preprocess
#SBATCH --output=bin_%j.out
#SBATCH --mail-user=USER@DOMAIN
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1
#SBATCH --mem=999gb
#SBATCH --time=12:00:00
#SBATCH --partition=hpg-ai

pwd; hostname; date
CONTAINER=./containers/pytorch.sif # a container has no megatron and nemo installed
singularity exec $CONTAINER python merge_megatron_preprocessing_bin_files.py \
    --input ./to_merge \
    --output ./uf_full_uf30kcased \
    --output_prefix uf_full_uf30kcased_TEXT \
    --vocab_file ./vocab.txt \
    --tokenizer_type BertWordPieceCase
date
