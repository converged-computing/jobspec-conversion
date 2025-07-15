#!/bin/bash
#FLUX: --job-name=minimal
#FLUX: --urgency=16

cd /om/user/sanjanas/minimal-cifar/
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om --nv /om/user/xboix/share/localtensorflow.img \
python /om/user/sanjanas/minimal-cifar/main.py ${SLURM_ARRAY_TASK_ID}
