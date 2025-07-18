#!/bin/bash
#FLUX: --job-name=nerdy-itch-4816
#FLUX: --queue=bosch_cpu-cascadelake
#FLUX: --urgency=16

source activate dac
experi="1D"
expdir="experiments/other_${experi}-DIST"
cmd="dac/train/train_other.py -r 1 -n 100000 --bo -s ${SLURM_ARRAY_TASK_ID} --env ${experi} --out-dir ${expdir}"
if [ $SLURM_ARRAY_TASK_ID -le 25 ]; then
    python $cmd 
    exit $?
fi
