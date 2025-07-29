#!/bin/bash
#FLUX: --job-name=synthetic
#FLUX: --queue=use-everything
#FLUX: -t=43200
#FLUX: --urgency=16

hostname
module add openmind/singularity/3.4.1
arrayexperiments=(3 4 5 6)
for i in "${arrayexperiments[@]}"
do
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow2.simg \
python /om/user/vanessad/synthetic_framework/main.py \
--host_filesystem om \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--offset_index 0 \
--run train \
--dataset_name dataset_$i \
--repetition_folder_path $i
done
