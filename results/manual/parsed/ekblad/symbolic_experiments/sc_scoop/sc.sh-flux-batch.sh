#!/bin/bash
#FLUX: --job-name=symb_class
#FLUX: -N=3
#FLUX: -n=96
#FLUX: --exclusive
#FLUX: --queue=high
#FLUX: -t=59999940
#FLUX: --urgency=16

export PATH='$GDIR/miniconda3/bin:$PATH'

GDIR=/group/hermangrp
export PATH=$GDIR/miniconda3/bin:$PATH
hosts=$(srun bash -c hostname)
source activate py37
python -m scoop --host $hosts -v sc.py $SLURM_ARRAY_TASK_ID
