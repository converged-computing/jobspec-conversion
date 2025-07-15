#!/bin/bash
#FLUX: --job-name=psycho-poodle-8797
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --urgency=16

export DISABLE_PBAR='1'

module purge
module load miniconda
source activate bayes
export DISABLE_PBAR=1
MAX_STEPS=2000
OUTDIR="zoo/sst/edl"
METHOD="edl"
python train.py \
    --method $METHOD \
    --dataset SSTBERT --transform normalize_x_sst \
    --model SSTNetEDL \
    --max-steps $MAX_STEPS \
    --batch-size 256 \
    --outdir $OUTDIR \
    --prefix $METHOD-$SLURM_ARRAY_TASK_ID
