#!/bin/bash
#FLUX: --job-name=predict
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/sw/apps/cuda/9.0.176/lib64/:/sw/apps/cudnn/6.0/lib64/'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/sw/apps/cuda/9.0.176/lib64/:/sw/apps/cudnn/6.0/lib64/
INPUT="3-predict/source"
OUTPUT="3-predict/restored"
FILES=(${INPUT}/*.tif)
FILE=`basename ${FILES[$SLURM_ARRAY_TASK_ID]}`
python3 predict.py \
--input-dir     "${INPUT}" \
--input-pattern "${FILE}" \
--input-axes    "ZYX" \
--model-basedir "1-models" \
--model-name    "proper" \
--factor        "3" \
--output-dir    "${OUTPUT}" \
--output-name   "{file_name}{file_ext}" \
--output-dtype  "uint16" \
--n-tiles       2 8 8
