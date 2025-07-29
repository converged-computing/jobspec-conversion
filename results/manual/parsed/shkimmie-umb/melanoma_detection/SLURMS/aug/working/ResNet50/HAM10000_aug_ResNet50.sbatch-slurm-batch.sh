#!/bin/bash
#FLUX: --job-name=HAM10000_1_ResNet50_150h_150w
#FLUX: -n=6
#FLUX: --queue=haehn_unlim
#FLUX: -t=86400
#FLUX: --urgency=16

eval "$(conda shell.bash hook)"
conda activate clean_chimera_env
echo `date`
python --version
nvcc -V
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
cd /home/sanghyuk.kim001/MELANOMA/melanoma-detection-CNN/
python train.py --DB HAM10000 --IMG_SIZE 150 150 --CLASSIFIER ResNet50 --SELF_AUG 1 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
