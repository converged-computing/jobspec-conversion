#!/bin/bash
#FLUX: --job-name=ec_first
#FLUX: -c=8
#FLUX: -t=36000
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
wid=$((SLURM_ARRAY_TASK_ID))
sleep $((30))
parentdir="${PWD%/*}"
$parentdir/scripts/train_models.sh --vertices=5 --edges=9 --epochs=108 --graph_file="5V9E_sample_700" --workers=16 --worker_id=$wid --worker_offset=0 --verbose
