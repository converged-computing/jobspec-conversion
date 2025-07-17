#!/bin/bash
#FLUX: --job-name=HAM10000_1_ResNet101V2_640h_640w
#FLUX: -n=4
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
python train.py --DB HAM10000 --IMG_SIZE 640 640 --CLASSIFIER ResNet101V2 --JOB_INDEX $SLURM_ARRAY_TASK_ID
echo "Job ended!"
exit 0;
