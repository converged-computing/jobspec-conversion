#!/bin/bash
#FLUX: --job-name=1_qem_crops_train
#FLUX: -t=1209600
#FLUX: --urgency=16

cd ../../../
python3.7 crop_training_samples.py \
--in_path data/scannet_qem_train_rooms/ \
--out_path data/scannet_qem_train_crops/ \
--block_size 3.0 \
--stride 1.5 \
--number $((SLURM_ARRAY_TASK_ID))
