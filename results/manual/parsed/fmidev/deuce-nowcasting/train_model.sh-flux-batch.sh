#!/bin/bash
#FLUX: --job-name=train_model
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

module load pytorch
srun python train_model.py config/deuce/deuce default --model bcnn --data fmi --callback ensemble &> train_model.out
seff $SLURM_JOBID
