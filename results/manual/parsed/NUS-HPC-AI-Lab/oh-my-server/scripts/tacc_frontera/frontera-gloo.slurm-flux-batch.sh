#!/bin/bash
#FLUX: --job-name=frigid-hope-8615
#FLUX: --priority=16

export PMI_NO_PREINITIALIZE='1  # avoid warnings on fork'

pwd
date
source ~/python-env/cuda10-home/bin/activate
module load intel/18.0.5 impi/18.0.5
module load cuda/10.1 cudnn nccl
cd /file_path/
export PMI_NO_PREINITIALIZE=1  # avoid warnings on fork
for node in $(scontrol show hostnames); do
   HOSTS="$HOSTS$node:4,"
done
HOSTS=${HOSTS%?}  # trim trailing comma
echo HOSTS $HOSTS
horovodrun -np $SLURM_NTASKS -H $HOSTS --gloo --network-interface ib0 \
   --start-timeout 120 --gloo-timeout-seconds 120 \
python you_file.py  \
--epochs 90 \
--model resnet50
