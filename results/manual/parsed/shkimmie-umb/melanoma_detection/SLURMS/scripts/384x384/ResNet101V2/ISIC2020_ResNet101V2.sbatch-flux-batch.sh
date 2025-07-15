#!/bin/bash
#FLUX: --job-name=ISIC2020_1_ResNet101V2_384h_384w
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate clean_chimera_env
echo `date`
python --version
nvcc -V
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cd /home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/
python train.py --DB ISIC2020 --IMG_SIZE 384 384 --CLASSIFIER ResNet101V2 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
