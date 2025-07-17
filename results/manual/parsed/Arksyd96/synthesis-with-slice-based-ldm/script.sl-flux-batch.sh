#!/bin/bash
#FLUX: --job-name=fugly-latke-4293
#FLUX: -c=6
#FLUX: --queue=gpu_all
#FLUX: -t=259200
#FLUX: --urgency=16

export PYTHONUSERBASE='/home/2021012/sruan01/riles/env'

module load aidl/pytorch/1.11.0-cuda11.3
export PYTHONUSERBASE=/home/2021012/sruan01/riles/env
pip install pytorch-lightning --user
srun python3 $1
