#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --priority=16

module load openmind/singularity/older_versions/2.4
singularity exec --nv -B /om:/om /om/user/larend/localtensorflow.img \
python /om/user/larend/robust/train/cifar10/train.py \
--model_index="${SLURM_ARRAY_TASK_ID}" --host_filesystem=/om
