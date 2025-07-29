#!/bin/bash
#FLUX: --job-name=test_job
#FLUX: -N=4
#FLUX: -c=2
#FLUX: --queue=compute_full_node
#FLUX: -t=86400
#FLUX: --urgency=16

export CUBLAS_WORKSPACE_CONFIG=':4096:2'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module --ignore_cache load cuda/11.4.4
module --ignore_cache load anaconda3
source activate pytorch
cd /scratch/g/gfilion/gfilion
export CUBLAS_WORKSPACE_CONFIG=:4096:2
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python ./pretrain_MLM.py majestic_tokenizer.json flat_claims.txt.gz trained.pt
