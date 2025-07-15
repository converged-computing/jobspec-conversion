#!/bin/bash
#FLUX: --job-name=loopy-lizard-0384
#FLUX: --priority=16

export LD_LIBRARY_PATH='~/miniconda3/lib'

source ~/.bashrc; conda activate ntrans
export LD_LIBRARY_PATH=~/miniconda3/lib
data_dir='/lustre/groups/epigenereg01/workspace/projects/vale/mlm'
fasta=$data_dir/'fasta/Homo_sapiens_rna.fa'
checkpoint_dir=$data_dir/'models/dnabert-3utr/checkpoints/epoch_30/'
output_dir=$data_dir/'human_3utr/probs/dnabert-3utr/'
mkdir -p $output_dir
fold=${SLURM_ARRAY_TASK_ID}
python -u dna_bert_eval.py $fasta $checkpoint_dir $output_dir $fold
