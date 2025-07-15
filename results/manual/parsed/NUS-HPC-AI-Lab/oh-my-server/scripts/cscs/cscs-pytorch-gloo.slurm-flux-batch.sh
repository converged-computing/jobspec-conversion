#!/bin/bash
#FLUX: --job-name=gloo-eb
#FLUX: -N=4
#FLUX: -t=1800
#FLUX: --urgency=16

export PMI_NO_PREINITIALIZE='1  # avoid warnings on fork'

module load daint-gpu PyTorch
. /users/lyongbin/miniconda3/bin/activate your_env_name
export PMI_NO_PREINITIALIZE=1  # avoid warnings on fork
for node in $(scontrol show hostnames); do
   HOSTS="$HOSTS$node:$SLURM_NTASKS_PER_NODE,"
done
HOSTS=${HOSTS%?}  # trim trailing comma
echo HOSTS $HOSTS
horovodrun -np $SLURM_NTASKS -H $HOSTS --gloo --network-interface ipogif0 \
   --start-timeout 120 --gloo-timeout-seconds 120 \
python -u your_code.py  \
--epochs 90 \
--model resnet50
