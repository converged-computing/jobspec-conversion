#!/bin/bash
#FLUX: --job-name=hw0_test
#FLUX: --queue=debug_5min
#FLUX: -t=120
#FLUX: --priority=16

. /home/fagg/tf_setup.sh
conda activate tf
python hw_0.py --epochs 7000 --hidden 16 --exp $SLURM_ARRAY_TASK_ID
