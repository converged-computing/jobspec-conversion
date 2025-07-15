#!/bin/bash
#FLUX: --job-name=test
#FLUX: --queue=submit-gpu1080
#FLUX: -t=24600
#FLUX: --priority=16

source /home/submit/freerc/.bashrc
conda activate dask
hostname
nvidia-smi
python cuda_test.py $1 -v $SLURM_ARRAY_TASK_ID
nvidia-smi
