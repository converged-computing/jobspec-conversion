#!/bin/bash
#FLUX: --job-name=rep4
#FLUX: --queue=cbmm
#FLUX: -t=28800
#FLUX: --urgency=16

hostname
module add openmind/singularity/3.4.1
offset_array=(11396 11896 12396 12896 13396 13896 14396)
repetition=("repetition_4")
for j in "${repetition[@]}"
do
  for i in "${offset_array[@]}"
  do
  singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow2.simg \
  python /om/user/vanessad/MNIST_framework/main.py \
   --host_filesystem om \
   --experiment_index ${SLURM_ARRAY_TASK_ID} \
   --offset_index $i \
   --run train \
   --repetition_folder_path $j
  done
done
