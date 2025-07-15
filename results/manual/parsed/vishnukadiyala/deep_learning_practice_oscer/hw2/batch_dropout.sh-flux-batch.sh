#!/bin/bash
#FLUX: --job-name=hw2_dropout3
#FLUX: -c=10
#FLUX: --queue=normal
#FLUX: -t=1800
#FLUX: --priority=16

. /home/fagg/tf_setup.sh
conda activate tf
python hw1_base_dropout.py --hidden 400 200 100 50 25 12 --activation_out linear --epochs 1000 --results_path ./results/dropout3 --exp_index $SLURM_ARRAY_TASK_ID --output_type ddtheta --predict_dim 1 --cpus_per_task $SLURM_CPUS_PER_TASK 
