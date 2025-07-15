#!/bin/bash
#FLUX: --job-name=faux-fudge-8918
#FLUX: -c=10
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export DATADIR='$LOCAL_SCRATCH'

module load tensorflow/nvidia-20.07-tf2-py3
module list
export DATADIR=$LOCAL_SCRATCH
set -xv
tar xf /scratch/project_2003959/data/dogs-vs-cats.tar -C $LOCAL_SCRATCH
python3 $*
