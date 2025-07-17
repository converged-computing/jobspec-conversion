#!/bin/bash
#FLUX: --job-name=ImageNet_SGV
#FLUX: -c=2
#FLUX: --queue=batch
#FLUX: -t=14400
#FLUX: --urgency=16

source activate upd_pt
nvidia-smi
python main.py \
--checkpoint runs/baseline \
--num-chunk ${SLURM_ARRAY_TASK_ID} \
--chunks 500 --eps 0.00784 --experiment imagenet_nominal_training
