#!/bin/bash
#FLUX: --job-name=predict
#FLUX: -c=4
#FLUX: --queue=g
#FLUX: -t=28800
#FLUX: --priority=16

SIF='/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cernml4reco/deepjetcore3:latest'
data_dir="/scratch-cbe/users/${USER}/DeepLepton"
input_data="${data_dir}/Train_DYvsQCD_rH_flat/dataCollection.djcdc"
output_dir="${data_dir}/Train_DYvsQCD_rH_flat/training_30/"
files="${data_dir}/traindata/DYvsQCD_2016/files_predict.txt"
model="${data_dir}/Train_DYvsQCD_rH_flat/training_30/KERAS_check_model_last.h5"
/scratch-cbe/users/maximilian.moser/DeepLepton/Train_testpeak/training/KERAS_check_model_last.h5
if [ ! -e $input_data ]; then
    echo "Input data not found."
    exit 1
fi
nvidia-smi
singularity run --nv $SIF <<EOF
set -x
source env.sh
predict.py  $model $input_data $files $output_dir -b  4000
EOF
