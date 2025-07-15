#!/bin/bash
#FLUX: --job-name=qem_rooms_val
#FLUX: -t=1209600
#FLUX: --priority=16

cd ../../../
python3.7 graph_level_generation.py \
--in_path raw_data/scannet/scans \
--out_path data/scannet_qem_val_rooms/ \
--level_params 0.04 30 30 30 \
--train \
--val \
--qem \
--dataset scannet \
--number $((SLURM_ARRAY_TASK_ID))
