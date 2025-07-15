#!/bin/bash
#FLUX: --job-name=rad-training
#FLUX: --queue=bii-gpu
#FLUX: -t=259200
#FLUX: --priority=16

date
nvidia-smi
source env.sh
python training.py --rad --id $SLURM_ARRAY_TASK_ID --n 1534
