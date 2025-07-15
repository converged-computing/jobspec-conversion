#!/bin/bash
#FLUX: --job-name=foveation
#FLUX: --queue=cbmm
#FLUX: --urgency=16

hostname
module add openmind/singularity/3.4.1
arrayexperiments=(0 1000 2000 3000 4000 5000)
for i in "${arrayexperiments[@]}"
do
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow-vanessa.simg \
python /om/user/vanessad/IMDb_framework/main.py \
--host_filesystem om \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--offset_index $i \
--run train \
--repetition_folder_path 0
done
