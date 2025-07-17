#!/bin/bash
#FLUX: --job-name=confused-leg-7545
#FLUX: -c=4
#FLUX: -t=86530
#FLUX: --urgency=16

export NCCL_BLOCKING_WAIT='1  # Set this variable to use the NCCL backend'
export SLURM_ACCOUNT='def-jimmylin'
export SBATCH_ACCOUNT='$SLURM_ACCOUNT'
export SALLOC_ACCOUNT='$SLURM_ACCOUNT'

set -x
export NCCL_BLOCKING_WAIT=1  # Set this variable to use the NCCL backend
export SLURM_ACCOUNT=def-jimmylin
export SBATCH_ACCOUNT=$SLURM_ACCOUNT
export SALLOC_ACCOUNT=$SLURM_ACCOUNT
COMMAND="$0 $@"
SRCH_RANGE=${1-10_5_10} # or 10_0_5
cd pyserini
srun --unbuffered python -m pyserini.dsearch \
	--topics msmarco-passage-dev-subset \
	--index /lustre07/scratch/w32zhong/msmarco-passage-index-339094 \
	--device cuda:0 \
	--encoder ../encoders/colbert_vanilla_128 \
	--tokenizer ../encoders/tokenizer-bert-base-uncased \
	--search-range $(echo $SRCH_RANGE | sed -e 's/_/ /g') \
	--output msmarco-passage-$SLURM_JOBID-$SRCH_RANGE.run
	#--encoder ../encoders/colbert_distil_128 \
	#--tokenizer ../encoders/tokenizer-distilbert-base-uncased \
echo python -m pyserini.dsearch \
	--topics msmarco-passage-dev-subset \
	--index /lustre07/scratch/w32zhong/msmarco-passage-index-debug \
	--device cuda:0 \
	--encoder ../encoders/colbert_vanilla_128 \
	--tokenizer ../encoders/tokenizer-bert-base-uncased \
	--output msmarco-passage-debug.run
