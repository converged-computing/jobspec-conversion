#!/bin/bash
#FLUX: --job-name=hw0
#FLUX: --queue=normal
#FLUX: -t=120
#FLUX: --priority=16

. /home/fagg/tf_setup.sh
conda activate tf
python HW0.py --epochs 500 --hidden 500 --lrate 0.0000001 --activation selu --exp $SLURM_ARRAY_TASK_ID
