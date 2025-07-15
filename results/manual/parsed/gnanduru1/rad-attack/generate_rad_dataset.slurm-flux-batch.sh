#!/bin/bash
#FLUX: --job-name=rad-generate-dataset
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

date
nvidia-smi
source env.sh
python generate_rad_dataset.py --id $SLURM_ARRAY_TASK_ID --alpha=100 --n 3000
