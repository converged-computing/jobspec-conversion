#!/bin/bash
#FLUX: --job-name=fuzzy-nunchucks-9940
#FLUX: --urgency=16

source activate dac
experi="1D3M"
expdir="experiments/other_${experi}"
cmd="dac/train/train_other.py --seed ${SLURM_ARRAY_TASK_ID} -r 1 -n 100000 --epsilon_decay const -e 1 -l 1. --env ${experi} --out-dir ${expdir}"
if [ $SLURM_ARRAY_TASK_ID -le 25 ]; then
    python $cmd 
    exit $?
fi
