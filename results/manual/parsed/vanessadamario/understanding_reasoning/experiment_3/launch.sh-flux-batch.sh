#!/bin/bash
#FLUX: --job-name=NPS_ms2
#FLUX: --queue=normal
#FLUX: -t=126000
#FLUX: --urgency=16

module add openmind/singularity/3.4.1
hostname
singularity exec -B /om2:/om2 --nv /om/user/xboix/singularity/xboix-tensorflow2.5.0.simg python3 main.py \
--host_filesystem om2 \
--output_path results_NeurIPS_module_per_subtask_trial2 \
--offset_index 0 \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--run train
