#!/bin/bash
#FLUX: --job-name=arid-kitty-7249
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export DATADIR='/scratch/project_2003959/data'

module load tensorflow/nvidia-20.07-tf2-py3
module list
export DATADIR=/scratch/project_2003959/data
set -xv
python3 $*
