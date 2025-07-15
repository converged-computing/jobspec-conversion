#!/bin/bash
#FLUX: --job-name=dilation
#FLUX: --urgency=16

cd /om/user/xboix/src/insideness/
hostname
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow.simg \
python /om/user/xboix/src/insideness/main.py \
--experiment_index=$((${SLURM_ARRAY_TASK_ID} + 0)) \
--host_filesystem=om \
--network=multi_lstm_init \
--run=train \
--error_correction
