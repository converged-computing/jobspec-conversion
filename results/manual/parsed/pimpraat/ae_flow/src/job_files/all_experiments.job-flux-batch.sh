#!/bin/bash
#FLUX: --job-name=RunAE_Normalized_Flow_Development
#FLUX: -c=3
#FLUX: --queue=gpu_titanrtx_shared_course
#FLUX: -t=1200
#FLUX: --urgency=16

module purge
module load 2021
module load Anaconda3/2021.05
source activate dl2022
srun python -u train.py --dataset chest_xray --subnet_architecture resnet_like --model ae_flow --final_experiments False -fully_deterministic True --epochs 100 --seed 42 
srun python -u train.py --dataset chest_xray --loss_beta 0.0 --model ae_flow --final_experiments False -fully_deterministic True --epochs 100 --seed 42 
