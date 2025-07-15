#!/bin/bash
#FLUX: --job-name=quirky-parrot-6383
#FLUX: --queue=gpu3
#FLUX: -t=172800
#FLUX: --urgency=16

export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=''
export HDF5_USE_FILE_LOCKING='FALSE'

module load cuda/cuda-9.0.176
module load cudnn/cudnn-7.1.4-cuda-9.0.176
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
source /storage/htc/bdm/zhiye/DNCON4/env/dncon4_virenv/bin/activate
python train_v3_all_data.py /storage/htc/bdm/farhan/DNCON2_features_homodimers/feat /storage/htc/bdm/farhan/DNCON2_features_homodimers/Y-Labels ../training_lists/same/
