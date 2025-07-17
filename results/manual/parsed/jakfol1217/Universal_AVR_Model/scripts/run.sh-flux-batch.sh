#!/bin/bash
#FLUX: --job-name=salted-egg-6127
#FLUX: -c=8
#FLUX: --queue=short
#FLUX: -t=86400
#FLUX: --urgency=16

date "+%Y-%m-%d %H:%M:%S"
echo "SLURMD_NODENAME: ${SLURMD_NODENAME}"
echo "SLURM_JOB_ID: ${SLURM_JOB_ID}"
echo "CUDA_VISIBLE_DEVICES: ${CUDA_VISIBLE_DEVICES}"
echo "singularity version: $(singularity version)"
echo "nvidia-container-toolkit version: $(nvidia-container-toolkit -version)"
echo "nvidia-container-cli info: $(nvidia-container-cli info)"
echo "Command: python ${1}" "${@:2}"
echo "$(date '+%Y-%m-%d %H:%M:%S'): [run.sh], JOB_ID ${SLURM_JOB_ID}, python ${1}" "${@:2}" >> /mnt/evafs/groups/mandziuk-lab/akaminski/out/commands.log
singularity run \
    --nv \
    --bind ~/Universal_AVR_Model/src:/app/src:ro \
    --bind ~/Universal_AVR_Model/.env:/app/.env:ro \
    --bind /mnt/evafs/groups/mandziuk-lab/akaminski/datasets:/app/data:ro \
    --bind ~/Universal_AVR_Model/model_checkpoints:/app/model_checkpoints:rw \
    --bind /mnt/evafs/groups/mandziuk-lab/akaminski/out:/app/out:rw \
    ~/singularity/universal-avr-system-nvidia-latest.sif \
    "${1}" "${@:2}"
echo "Singularity exited with code: $?"
date "+%Y-%m-%d %H:%M:%S"
