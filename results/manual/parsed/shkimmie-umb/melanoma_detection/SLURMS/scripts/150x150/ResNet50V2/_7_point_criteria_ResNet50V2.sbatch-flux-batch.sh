#!/bin/bash
#FLUX: --job-name=_7_point_criteria_1_ResNet50V2_150h_150w
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate clean_chimera_env
echo `date`
python --version
nvcc -V
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cd /home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/
python train.py --DB _7_point_criteria --IMG_SIZE 150 150 --CLASSIFIER ResNet50V2 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
