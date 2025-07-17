#!/bin/bash
#FLUX: --job-name=summarize_cam5
#FLUX: -t=3600
#FLUX: --urgency=16

rankspernode=48
totalranks=$(( ${SLURM_NNODES} * ${rankspernode} ))
srun --wait=60 --mpi=pmix -N ${SLURM_NNODES} -n ${totalranks} -c $(( 96 / ${rankspernode} )) \
     --container-workdir=/opt/utils \
     --container-mounts=/gpfs/fs1/tkurth/cam5_dataset/All-Hist:/data \
     --container-image=gitlab-master.nvidia.com/tkurth/mlperf-deepcam:debug \
     python summarize_data.py
