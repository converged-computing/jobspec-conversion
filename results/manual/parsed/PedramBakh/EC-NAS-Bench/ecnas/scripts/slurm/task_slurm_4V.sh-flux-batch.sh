#!/bin/bash
#FLUX: --job-name=ec_4V
#FLUX: -c=8
#FLUX: -t=36000
#FLUX: --urgency=16

hostname
echo $CUDA_VISIBLE_DEVICES
wid=$((SLURM_ARRAY_TASK_ID))
sleep $((30))
parentdir="${PWD%/*}"
$parentdir/scripts/train_models.sh --vertices=4 --edges=9 --epochs=108 --graph_file="4V9E_all_91" --workers=8 --worker_id=$wid --worker_offset=0 --verbose
