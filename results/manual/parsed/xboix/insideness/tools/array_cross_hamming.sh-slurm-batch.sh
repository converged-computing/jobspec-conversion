#!/bin/bash
#FLUX: --job-name=insideness
#FLUX: -n=2
#FLUX: -t=360000
#FLUX: --urgency=16

cd /om/user/xboix/src/insideness/
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om  --nv /om/user/xboix/singularity/xboix-tensorflow.simg \
python /om/user/xboix/src/insideness/main.py \
--experiment_index=${SLURM_ARRAY_TASK_ID} \
--host_filesystem=om \
--run=cross_dataset_hamming \
--network=crossing
