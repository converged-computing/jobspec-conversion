#!/bin/bash
#FLUX: --job-name=BDD100K_preprocessing
#FLUX: --queue=compute-od-gpu
#FLUX: -t=356982
#FLUX: --urgency=16

export RAY_OBJECT_STORE_ALLOW_SLOW_STORAGE='0'
export JOBLIB_TEMP_FOLDER='/tmp'

CUDA_VISIBLE_DEVICES=-1 #no GPUs
TF_CPP_MIN_LOG_LEVEL=0 #logging
grep MemTotal /proc/meminfo
lscpu
nvidia-smi
export RAY_OBJECT_STORE_ALLOW_SLOW_STORAGE=0
export JOBLIB_TEMP_FOLDER=/tmp
pip3 install joblib psutil
singularity exec -B /fsx/awesome/temp/:/fsx/awesome/temp/ tfio_modified.sif python3 ./scripts/Final_converter.py
