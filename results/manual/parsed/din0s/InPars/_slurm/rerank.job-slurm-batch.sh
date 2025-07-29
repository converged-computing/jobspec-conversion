#!/bin/bash
#FLUX: --job-name=RerankInPars
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load 2022
module load Anaconda3/2022.05
source activate thesis
cd $HOME/InPars
mkdir -p runs
CHUNK_IDX=$((SLURM_ARRAY_TASK_ID - 1))
python -u \
    -m inpars.rerank \
    --model ./models/arguana/ \
    --dataset arguana \
    --chunk_queries $SLURM_ARRAY_TASK_MAX \
    --chunk_idx $CHUNK_IDX \
    --output_run ./runs/arguana_$CHUNK_IDX.txt \
    --batch_size 128 \
    --bf16
