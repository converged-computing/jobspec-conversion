#!/bin/bash
#FLUX: --job-name=teacher_clas
#FLUX: --queue=use-everything
#FLUX: --priority=16

hostname
module add openmind/singularity/3.4.1
experiment_id=(0 110 220 330 440 550 660 770 880 990 1100 1210 1320 1430 1540 1650 1760 1870 1980 2090)
for i in "${experiment_id[@]}"
do
  singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow2.simg \
  python /om/user/vanessad/synthetic_framework/main.py \
  --host_filesystem om \
  --experiment_index  ${SLURM_ARRAY_TASK_ID} \
  --offset_index $i \
  --run train \
  --dataset_name teacher_1_classification \
  --repetition_folder_path teacher_2_classification
done
