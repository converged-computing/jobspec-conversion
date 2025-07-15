#!/bin/bash
#FLUX: --job-name=foveation
#FLUX: --queue=cbmm
#FLUX: --urgency=16

hostname
module add openmind/singularity/3.4.1
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow-vanessa.simg \
python /om/user/vanessad/IMDb_framework/main.py \
--host_filesystem om \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--offset_index 0 \
--run train \
--repetition_folder_path kim_init_weights
