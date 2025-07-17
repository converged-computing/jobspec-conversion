#!/bin/bash
#FLUX: --job-name=1_true
#FLUX: -c=4
#FLUX: --queue=cbmm
#FLUX: -t=86400
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'

cd /om/user/shobhita/src/chexpert/src/6.819FinalProjectRAMP
hostname
export CUDA_VISIBLE_DEVICES=0
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tf_fujitsu3.simg \
python /om/user/shobhita/src/chexpert/src/6.819FinalProjectRAMP/main.py --idx=${SLURM_ARRAY_TASK_ID} --user="shobhita" --with_gan=True --dataset_size=1 --skip_training=
