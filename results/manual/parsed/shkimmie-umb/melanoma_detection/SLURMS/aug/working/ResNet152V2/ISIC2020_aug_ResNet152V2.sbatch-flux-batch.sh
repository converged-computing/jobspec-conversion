#!/bin/bash
#FLUX: --job-name=ISIC2020_1_ResNet152V2_150h_150w
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate clean_chimera_env
echo `date`
python --version
nvcc -V
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cd /home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/
python train.py --DB ISIC2020 --IMG_SIZE 150 150 --CLASSIFIER ResNet152V2 --SELF_AUG 1 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
