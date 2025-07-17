#!/bin/bash
#FLUX: --job-name=evasive-bits-3388
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=10800
#FLUX: --urgency=16

export MODULEPATH='/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH'

module purge
export MODULEPATH=/mnt/home/gkrawezik/modules/rocky8:$MODULEPATH
module load openmpi python-mpi
module load modules/2.1 cuda/12.0 cudnn/cuda12-8.8.0
source ~/envs/score_pytorch_h100/bin/activate
python sample.py $SLURM_ARRAY_TASK_ID fiducial/
