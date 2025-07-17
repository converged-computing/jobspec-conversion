#!/bin/bash
#FLUX: --job-name=faux-diablo-9767
#FLUX: -c=4
#FLUX: -t=610
#FLUX: --urgency=16

export NCCL_BLOCKING_WAIT='1  # Set this variable to use the NCCL backend'
export SLURM_ACCOUNT='def-jimmylin'
export SBATCH_ACCOUNT='$SLURM_ACCOUNT'
export SALLOC_ACCOUNT='$SLURM_ACCOUNT'

set -x
N_NODE=$(cat $0 | grep -Po '(?<=SBATCH --nodes=)[0-9]+')
N_GPUS=$(cat $0 | grep -Po '(?<=SBATCH --gres=gpu:)[0-9]+')
export NCCL_BLOCKING_WAIT=1  # Set this variable to use the NCCL backend
export SLURM_ACCOUNT=def-jimmylin
export SBATCH_ACCOUNT=$SLURM_ACCOUNT
export SALLOC_ACCOUNT=$SLURM_ACCOUNT
cd pyserini
srun --unbuffered python -m pyserini.encode \
	input --corpus ../msmarco-passage-corpus \
	encoder --encoder ../encoders/colbert_vanilla_128 \
	--tokenizer ../encoders/tokenizer-bert-base-uncased \
	--batch 90 --fp16 --device cuda:0 \
	output --embeddings /lustre07/scratch/w32zhong/msmarco-passage-index-$SLURM_JOBID
echo python -m pyserini.encode \
	input --corpus ../msmarco-passage-debugcorpus \
	encoder --encoder ../encoders/colbert_vanilla_128 \
	--tokenizer ../encoders/tokenizer-bert-base-uncased \
	--batch 1 --fp16 --device cuda:0 \
	output --embeddings /lustre07/scratch/w32zhong/msmarco-passage-index-debug
