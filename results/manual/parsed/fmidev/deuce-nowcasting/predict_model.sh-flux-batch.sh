#!/bin/bash
#FLUX: --job-name=predict_model
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=36000
#FLUX: --priority=16

module load pytorch
srun python predict_model.py data/deuce_model_checkpoints/deuce_model.ckpt config/deuce/deuce_continue_2 default --model bcnn --data fmi &> predict_model.out
seff $SLURM_JOBID
