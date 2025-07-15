#!/bin/bash
#FLUX: --job-name=rainbow-lettuce-3023
#FLUX: -t=86400
#FLUX: --priority=16

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
echo "This script aims to crop original -> generate SR -> assemble generated SR"
cd /u/wangqi/git_wq/3d_super-resolution_mri/mains/inference
srun python /u/wangqi/git_wq/3d_super-resolution_mri/mains/inference/inference.py --CkpName instancenoise --epoch 39 --RootPath /ptmp/wangqi/saved_models --hr_path /ptmp/wangqi/transfer_folder/LS200X_Norm/LS2009_demean.nii.gz --save_nii 1
echo "Jobs finished"
