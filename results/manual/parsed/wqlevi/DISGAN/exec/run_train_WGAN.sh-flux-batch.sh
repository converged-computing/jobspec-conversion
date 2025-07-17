#!/bin/bash
#FLUX: --job-name=TORCH-GPU
#FLUX: -t=86400
#FLUX: --urgency=16

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
srun python ../mains/ESRGAN_WGAN_GP_L1.py --train_path /ptmp/wangqi/transfer_folder/LS200X_Norm/train_crops --model C18_WGANGP_l1_FE --checkpoint 20 --precision 1 --batch_size 4 --lr .0002
echo "Jobs finished"
