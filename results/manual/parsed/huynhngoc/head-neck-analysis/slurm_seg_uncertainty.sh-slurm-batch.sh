#!/bin/bash
#FLUX: --job-name=uncertainty
#FLUX: --queue=gpu
#FLUX: --urgency=16

export NUM_CPUS='4'
export RAY_ROOT='$TMPDIR/ray'
export MAX_SAVE_STEP_GB='0'

module load singularity
if [ $# -lt 2 ];
    then
    printf "Not enough arguments - %d\n" $#
    exit 0
    fi
echo "Finished seting up files."
export NUM_CPUS=4
export RAY_ROOT=$TMPDIR/ray
export MAX_SAVE_STEP_GB=0
rm -rf $TMPDIR/ray/*
singularity exec --nv deoxys-2023-feb-fixed.sif python -u run_uncertainty.py $1 $PROJECTS/ngoc/segmentation --dropout_rate $2 --iter $SLURM_ARRAY_TASK_ID
