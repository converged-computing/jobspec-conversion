#!/bin/bash
#FLUX: --job-name=cfg-delay
#FLUX: -c=8
#FLUX: --urgency=16

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
echo
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; 
python main_cfg_delay.py
echo "finish"
