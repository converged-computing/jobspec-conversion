#!/bin/bash
#FLUX: --job-name=faux-eagle-8020
#FLUX: --exclusive
#FLUX: --urgency=16

export USE_EXASCALE_API='True # "True" or "False" use granular host/device memory transfer'
export LOG_BY_RANK='1 # Use Aaron's profiler/rank logger'
export N_SIM='240 # total number of images to simulate'
export ADD_SPOTS_ALGORITHM='cuda # cuda or JH or NKS'
export DEVICES_PER_NODE='8'

export USE_EXASCALE_API=True # "True" or "False" use granular host/device memory transfer
export LOG_BY_RANK=1 # Use Aaron's profiler/rank logger
export N_SIM=240 # total number of images to simulate
export ADD_SPOTS_ALGORITHM=cuda # cuda or JH or NKS
export DEVICES_PER_NODE=8
mkdir -p LS49/$SLURM_JOB_ID;
cd LS49/$SLURM_JOB_ID
date;ls
srun python $(libtbx.find_in_repositories LS49)/adse13_196/step5_batch.py
date;ls
sleep 5
