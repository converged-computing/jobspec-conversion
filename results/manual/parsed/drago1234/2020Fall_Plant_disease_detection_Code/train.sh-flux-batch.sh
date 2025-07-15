#!/bin/bash
#FLUX: --job-name=plant_disease_diagnosis
#FLUX: --queue=gpuserial-48core
#FLUX: -t=172800
#FLUX: --urgency=16

export PYTHONNOUSERSITE='true'

echo 'environemnt set up'
source ./miniconda3/bin/activate
module load cuda/11.0.3 
export PYTHONNOUSERSITE=true
conda activate tf_latest
echo 'Running the batch script'
python plant_leaves_diagnosis/InceptionV3_model.py # baseline_backup.py baseline_InceptionV3.py baseline_ResNet.py baseline_debug.py baseline_NASNet.py
echo 
qstat -u dong760 
echo 'The date when running current script is :'
date
