#!/bin/bash
#FLUX: --job-name=MultiModal
#FLUX: -c=4
#FLUX: -t=14400
#FLUX: --urgency=16

exp_id=$1
ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif
singularity exec --nv --bind /scratch \
--overlay ${ext3_path}:ro ${sif_path} \
/bin/bash -c "
source /ext3/env.sh
cd /scratch/$USER/wx-challenge
python main.py \
    --savedmodel_path save/${exp_id} \
    > logs/${exp_id}.log 2>&1
"
