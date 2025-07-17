#!/bin/bash
#FLUX: --job-name=bumfuzzled-toaster-9096
#FLUX: -n=2
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export DATADIR='/scratch/project_2003959/data'
export KERAS_HOME='/scratch/project_2003959/keras-cache'

module load tensorflow/nvidia-20.07-tf2-py3
module list
export DATADIR=/scratch/project_2003959/data
export KERAS_HOME=/scratch/project_2003959/keras-cache
set -xv
srun python3 $*
