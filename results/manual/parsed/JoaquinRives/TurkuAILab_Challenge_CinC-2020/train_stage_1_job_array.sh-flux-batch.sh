#!/bin/bash
#FLUX: --job-name=002
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=244800
#FLUX: --priority=16

module load tensorflow/1.14.0 gcc/8.3.0 cuda/10.1.168
list_args="model_1_1 model_1_2 model_1_3 model_1_4"
arr=($list_args)
srun python train_stage_1.py ${arr[${SLURM_ARRAY_TASK_ID} - 1]}
