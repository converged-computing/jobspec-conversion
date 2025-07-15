#!/bin/bash
#FLUX: --job-name=hw1_run4
#FLUX: --queue=normal
#FLUX: -t=1800
#FLUX: --urgency=16

. /home/fagg/tf_setup.sh
conda activate tf
python hw1_base.py --hidden 1000 --activation_out linear --epochs 1000 --results_path ./results/r1 --exp_index $SLURM_ARRAY_TASK_ID --output_type ddtheta --predict_dim 0
