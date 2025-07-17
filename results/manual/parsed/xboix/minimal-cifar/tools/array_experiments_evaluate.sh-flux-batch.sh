#!/bin/bash
#FLUX: --job-name=minimal
#FLUX: -n=2
#FLUX: -t=3600
#FLUX: --urgency=16

hostname
cd /om/user/sanjanas/minimal-cifar/
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om --nv /cbcl/cbcl01/xboix/singularity/localtensorflow.img \
python /om/user/sanjanas/minimal-cifar/test_minimal.py ${SLURM_ARRAY_TASK_ID}
