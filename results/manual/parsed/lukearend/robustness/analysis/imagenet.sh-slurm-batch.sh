#!/bin/bash
#FLUX: --job-name=imagenet
#FLUX: -c=8
#FLUX: -t=64800
#FLUX: --urgency=16

SCALE_FACTOR=('0.25' '0.5' '1' '2' '4')
module load openmind/singularity/older_versions/2.4
singularity exec --nv -B /om:/om /om/user/larend/localtensorflow.img \
python /om/user/larend/robust/analysis/activations.py \
--model_dir=/om/user/larend/models/robust/imagenet/0000${SLURM_ARRAY_TASK_ID} \
--scale_factor=${SCALE_FACTOR[$SLURM_ARRAY_TASK_ID]} \
--dataset=imagenet \
--pickle_dir=/om/user/larend/robustpickles/imagenet/0000${SLURM_ARRAY_TASK_ID} \
--host_filesystem=/om
singularity exec --nv -B /om:/om /om/user/larend/localtensorflow.img \
python /om/user/larend/robust/analysis/redundancy.py \
--pickle_dir=/om/user/larend/robustpickles/imagenet/0000${SLURM_ARRAY_TASK_ID}
singularity exec --nv -B /om:/om /om/user/larend/localtensorflow.img \
python /om/user/larend/robust/analysis/robustness.py \
--model_dir=/om/user/larend/models/robust/imagenet/0000${SLURM_ARRAY_TASK_ID} \
--scale_factor=${SCALE_FACTOR[$SLURM_ARRAY_TASK_ID]} \
--dataset=imagenet \
--pickle_dir=/om/user/larend/robustpickles/imagenet/0000${SLURM_ARRAY_TASK_ID} \
--host_filesystem=/om
