#!/bin/bash
#FLUX: --job-name=rerun_train_data
#FLUX: -t=28800
#FLUX: --urgency=16

export OPENCV_OPENCL_RUNTIME=''

module load tensorflow
export OPENCV_OPENCL_RUNTIME=
python rerun_train_data.py
