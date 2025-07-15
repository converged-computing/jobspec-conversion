#!/bin/bash
#FLUX: --job-name=quirky-muffin-7987
#FLUX: --exclusive
#FLUX: --urgency=16

export USE_EXASCALE_API='True # "True" or "False" use granular host/device memory transfer'
export LOG_BY_RANK='1 # Use Aaron's rank logger'
export RANK_PROFILE='0 # 0 or 1 Use cProfiler, default 1'
export N_SIM='240 # total number of images to simulate'
export ADD_SPOTS_ALGORITHM='cuda # cuda or JH or NKS'
export ADD_BACKGROUND_ALGORITHM='cuda # cuda or jh or sort_stable'
export CACHE_FHKL_ON_GPU='True # "True" or "False" use single object per rank'
export DEVICES_PER_NODE='8'

export USE_EXASCALE_API=True # "True" or "False" use granular host/device memory transfer
export LOG_BY_RANK=1 # Use Aaron's rank logger
export RANK_PROFILE=0 # 0 or 1 Use cProfiler, default 1
export N_SIM=240 # total number of images to simulate
export ADD_SPOTS_ALGORITHM=cuda # cuda or JH or NKS
export ADD_BACKGROUND_ALGORITHM=cuda # cuda or jh or sort_stable
export CACHE_FHKL_ON_GPU=True # "True" or "False" use single object per rank
export DEVICES_PER_NODE=8
mkdir $SLURM_JOB_ID; cd $SLURM_JOB_ID
echo "jobstart $(date)";pwd;ls
srun -n 40 -c 2 libtbx.python $(libtbx.find_in_repositories LS49)/adse13_196/step5_batch.py
echo "jobend $(date)";pwd
