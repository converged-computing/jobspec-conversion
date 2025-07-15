#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=4
#FLUX: --queue=g
#FLUX: -t=172800
#FLUX: --priority=16

SIF='/cvmfs/unpacked.cern.ch/registry.hub.docker.com/cernml4reco/deepjetcore3:latest'
data_dir="/scratch-cbe/users/${USER}/DeepLepton"
input_data="${data_dir}/Train_DYvsQCD_rH_flat/dataCollection.djcdc"
output_dir="${data_dir}/Train_DYvsQCD_rH_flat/training_30"
if [ ! -e $input_data ]; then
    echo "Input data not found."
    exit 1
fi
if [ -e $output_dir ]; then
    echo "Output directory already exists"
    exit 1
fi
nvidia-smi
singularity run --nv $SIF <<EOF
set -x
source env.sh
python3 Train/DYvsQCD2016.py $input_data $output_dir
EOF
