#!/bin/bash
#FLUX: --job-name=gpuJob
#FLUX: -c=3
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load rhel7/default-gpu
module unload cuda/8.0
module load cuda/11.0 cuda/11.1 cudnn/8.0_cuda-11.1
source /home/<CRSid>/rds/hpc-work/tensorflow-env/bin/activate
SCRIPT="/home/<CRSid>/rds/hpc-work/trainLargeDNN.py"
srun python $SCRIPT
