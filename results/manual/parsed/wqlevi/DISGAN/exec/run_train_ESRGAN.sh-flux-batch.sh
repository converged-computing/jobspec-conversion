#!/bin/bash
#FLUX: --job-name=creamy-lizard-4744
#FLUX: -t=86400
#FLUX: --priority=16

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
srun python /u/wangqi/git_wq/3d_super-resolution_mri/mains/train_script_resnet10_tsboard.py --path /ptmp/wangqi/transfer_folder/LS200X_Norm/train_crops --model C20 --checkpoint 0 --precision 1 --batch_size 8 --lr .0002 --epoch 50
echo "Jobs finished"
