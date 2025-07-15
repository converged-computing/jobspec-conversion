#!/bin/bash
#FLUX: --job-name=eval
#FLUX: -c=8
#FLUX: --priority=16

echo "start"
echo "Starting job ${SLURM_JOB_ID} on ${SLURMD_NODENAME}"
echo
nvidia-smi
. /geoinfo_vol1/puzhao/miniforge3/etc/profile.d/conda.sh
conda activate pytorch
PYTHONUNBUFFERED=1; 
python3 s1s2_evaluator_prg.py \
            --config-name=s1s2_cfg_prg.yaml \
            DATA.SATELLITES=['S1'] \
            DATA.INPUT_BANDS.S2=['B4','B8','B12'] \
echo "finish"
