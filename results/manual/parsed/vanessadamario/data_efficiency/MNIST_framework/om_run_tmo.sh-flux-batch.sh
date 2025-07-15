#!/bin/bash
#FLUX: --job-name=avg_r2r
#FLUX: --queue=cbmm
#FLUX: --priority=16

module add openmind/singularity/3.4.1
offset_array=(6781)
repetition=("repetition_1" "repetition_2")
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
