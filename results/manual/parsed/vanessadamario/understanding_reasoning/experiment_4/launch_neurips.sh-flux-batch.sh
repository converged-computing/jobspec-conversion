#!/bin/bash
#FLUX: --job-name=groupall4
#FLUX: --queue=normal
#FLUX: --urgency=16

module add openmind/singularity/3.4.1
hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
singularity exec -B /om2:/om2 --nv /om/user/xboix/singularity/xboix-tensorflow2.5.0.simg python3 \
/om2/user/vanessad/understanding_reasoning/experiment_4/main.py \
--host_filesystem om2_exp4 \
--offset_index 0 \
--load_model True \
--output_folder results_NeurIPS_revision \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--run train
