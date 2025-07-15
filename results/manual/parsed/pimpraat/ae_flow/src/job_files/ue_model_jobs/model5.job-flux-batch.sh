#!/bin/bash
#FLUX: --job-name=AE_NF_UE_Model1
#FLUX: -c=3
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=50400
#FLUX: --priority=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate dl2022
srun python -u train.py --epochs 100 --dataset chest_xray --subnet_architecture resnet_like --model ae_flow --n_validation_folds 5 --num_workers 3 --seed 1 --ue_model True
