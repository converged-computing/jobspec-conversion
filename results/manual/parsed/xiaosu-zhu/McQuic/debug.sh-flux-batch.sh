#!/bin/bash
#FLUX: --job-name=mcquic_pretraining
#FLUX: -c=48
#FLUX: --queue=A800
#FLUX: --urgency=16

export HF_ENDPOINT='https://hf-mirror.com'
export PYTHONPATH='/ssdfs/datahome/tj24011/workspace/McQuic'

export HF_ENDPOINT="https://hf-mirror.com"
export PYTHONPATH="/ssdfs/datahome/tj24011/workspace/McQuic"
module load cuda/12.1
source /ssdfs/datahome/tj24011/software/miniconda3/etc/profile.d/conda.sh
conda activate mcquic
TOKENIZERS_PARALLELISM=false NCCL_P2P_LEVEL=NVL OMP_NUM_THREADS=16 srun torchrun --rdzv-backend=c10d --rdzv-endpoint=localhost:0 --nnodes=1 --nproc_per_node=1 mcquic/train/__main__.py configs/a800_16.yaml
