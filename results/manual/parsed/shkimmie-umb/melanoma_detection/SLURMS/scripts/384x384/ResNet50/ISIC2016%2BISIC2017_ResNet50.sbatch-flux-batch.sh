#!/bin/bash
#FLUX: --job-name=ISIC2016+ISIC2017_1_ResNet50_384h_384w
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate clean_chimera_env
echo `date`
python --version
nvcc -V
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cd /home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/
python train.py --DB ISIC2016 ISIC2017 --IMG_SIZE 384 384 --CLASSIFIER ResNet50 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
