#!/bin/bash
#FLUX: --job-name=loopy-kerfuffle-5275
#FLUX: --queue=bosch_cpu-cascadelake
#FLUX: --urgency=16

source activate dac
experi="2D3M"
expdir="experiments/other_${experi}"
cmd="dac/train/train_other.py -r 1 -n 100000 --bo -s ${SLURM_ARRAY_TASK_ID} --env ${experi} --out-dir ${expdir}"
files=($(echo ${expdir}/smac*/*))
if [ $SLURM_ARRAY_TASK_ID -le 25 ]; then
    python $cmd --validate-bo ${files[$SLURM_ARRAY_TASK_ID-1]}
    exit $?
fi
