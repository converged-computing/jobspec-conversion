#!/bin/bash
#FLUX: --job-name=crusty-lamp-9447
#FLUX: -t=86400
#FLUX: --priority=16

module purge 
module load anaconda/3/2020.02
module load cuda/11.2
module load nibabel/2.5.0
module load pytorch/gpu-cuda-11.2/1.8.1
srun python /u/wangqi/torch_env/crop_gan/test_crop_new.py --path /ptmp/wangqi/MPI_subj3/crops --subj MPRAGE --scale 2
echo "Jobs finished"
