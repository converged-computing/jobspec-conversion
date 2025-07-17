#!/bin/bash
#FLUX: --job-name=1_qem_rooms_matterport
#FLUX: -t=1209600
#FLUX: --urgency=16

cd ../../../
python3.7 graph_level_generation.py \
--in_path raw_data/matterport/v1/scans \
--out_path data/matterport/ \
--level_params 0.04 30 30 30 \
--train \
--qem \
--dataset matterport \
--number $((SLURM_ARRAY_TASK_ID))
