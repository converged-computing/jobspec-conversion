#!/bin/bash
#FLUX: --job-name=blank-earthworm-6227
#FLUX: --queue=shared-gpu
#FLUX: -t=43200
#FLUX: --urgency=16

echo $SLURM_JOBID
module load Anaconda3
source /opt/ebsofts/Anaconda3/2021.05/etc/profile.d/conda.sh
conda activate DeepFocus_final
CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES python3 -u FinalDeepFocus.py
