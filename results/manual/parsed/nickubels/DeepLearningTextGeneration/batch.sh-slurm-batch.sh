#!/bin/bash
#FLUX: --job-name=MTGA
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

INPUTFILE=input.in
ARGS=$(cat $INPUTFILE | head -n $SLURM_ARRAY_TASK_ID | tail -n 1)
module load Python/3.6.4-foss-2018a
module load CUDA/9.1.85
source venv/bin/activate
python3 main.py -j $SLURM_JOB_ID $ARGS
