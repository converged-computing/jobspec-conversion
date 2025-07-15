#!/bin/bash
#FLUX: --job-name=cifar_train
#FLUX: --queue=cbmm
#FLUX: --priority=16

cd /om/user/scasper/workspace/
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/resnet/cifar10_main.py \
--data_dir /om/user/scasper/redundancy/resnet/cifar_data/cifar-10-batches-bin/ \
--model_dir /om/user/scasper/workspace/models/resnet_cifar/ \
--opt_id ${SLURM_ARRAY_TASK_ID}
