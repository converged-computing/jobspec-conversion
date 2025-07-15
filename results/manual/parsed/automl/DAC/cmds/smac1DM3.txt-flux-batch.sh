#!/bin/bash
#FLUX: --job-name=boopy-arm-8380
#FLUX: --priority=16

source activate dac
experi="1D3M"
expdir="experiments/other_${experi}"
cmd="dac/train/train_other.py -r 1 -n 100000 --bo -s ${SLURM_ARRAY_TASK_ID} --env ${experi} --out-dir ${expdir}"
if [ $SLURM_ARRAY_TASK_ID -le 25 ]; then
    python $cmd 
    exit $?
fi
