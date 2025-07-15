#!/bin/bash
#FLUX: --job-name=NPS_exp1_1
#FLUX: --queue=use-everything
#FLUX: --urgency=16

module add openmind/singularity/3.4.1
hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
singularity exec -B /om2:/om2 --nv /om/user/xboix/singularity/xboix-tensorflow2.5.0.simg python3  \
 /om2/user/vanessad/understanding_reasoning/experiment_1/main.py \
--host_filesystem om2 \
--offset_index 0 \
--output_path /om2/user/vanessad/understanding_reasoning/experiment_1/results_NeurIPS_revision \
--run train \
--experiment_index ${SLURM_ARRAY_TASK_ID}
