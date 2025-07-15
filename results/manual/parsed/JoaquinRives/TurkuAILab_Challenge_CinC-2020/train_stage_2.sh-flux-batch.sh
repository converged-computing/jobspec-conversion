#!/bin/bash
#FLUX: --job-name=known
#FLUX: -c=10
#FLUX: --queue=small
#FLUX: -t=72000
#FLUX: --urgency=16

module load tensorflow/1.14.0
srun python3 train_stage_2.py
seff $SLURM_JOBID
