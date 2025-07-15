#!/bin/bash
#FLUX: --job-name=scruptious-lamp-5709
#FLUX: -c=4
#FLUX: -t=172800
#FLUX: --priority=16

echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
nvidia-smi
. ~/miniconda3/etc/profile.d/conda.sh
conda activate /Midgard/home/tibbe/mambaforge/envs/openpose
python main.py --config ${CONFIG} --project ${PROJECT_NAME}
