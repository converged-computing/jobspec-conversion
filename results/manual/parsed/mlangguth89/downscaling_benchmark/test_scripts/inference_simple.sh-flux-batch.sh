#!/bin/bash
#FLUX: --job-name=psycho-arm-3316
#FLUX: -c=40
#FLUX: --queue=develgpus
#FLUX: -t=7200
#FLUX: --urgency=16

WORK_DIR=$(pwd)
BASE_DIR=$(dirname "${WORK_DIR}")
ml --force purge
ml use $OTHERSTAGES
ml Stages/2022
ml GCCcore/.11.2.0
ml GCC/11.2.0
ml ParaStationMPI/5.5.0-1
ml netcdf4-python/1.5.7-serial
ml SciPy-bundle/2021.10
ml xarray/0.20.1
ml dask/2021.9.1
ml TensorFlow/2.6.0-CUDA-11.5
model_dir=${BASE_DIR}/trained_models/unet_test
data_dir=/p/scratch/deepacf/maelstrom/maelstrom_data/ap5_michael/preprocessed_tier2/  
srun --overlap python3 ./inference_simple.py -data_dir ${data_dir} -model_dir ${model_dir}
