#!/bin/bash
#FLUX: --job-name=LA
#FLUX: --queue=psych_gpu
#FLUX: -t=21600
#FLUX: --urgency=16

set -e
nvidia-smi
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch/
. /gpfs/milgram/apps/hpc.rhel7/software/Python/Anaconda3/etc/profile.d/conda.sh
conda activate py36
python --version
python -u /gpfs/milgram/pi/turk-browne/projects/sandbox/sandbox/docker/hello.py
cd /gpfs/milgram/project/turk-browne/projects/LocalAggregation-Pytorch
CUDA_VISIBLE_DEVICES=0 python -u ./scripts/instance.py  "${1}"
nvidia-smi
echo "done"
