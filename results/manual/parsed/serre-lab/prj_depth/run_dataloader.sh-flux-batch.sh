#!/bin/bash
#FLUX: --job-name=depth_dataset
#FLUX: -t=172800
#FLUX: --urgency=16

cd /users/aarjun1/data/aarjun1/prj_depth/
module load anaconda/3-5.2.0
module load python/3.5.2
module load cudnn/7.4
module load cuda/10.0.130
source activate color_CNN
echo $SLURM_ARRAY_TASK_ID
python -u pytorch_dataloader.py #--job_number $SLURM_JOB_ID --gpu_index $CUDA_VISIBLE_DEVICES #-n 1 -v single_illuminant -j $SLURM_ARRAY_TASK_ID
