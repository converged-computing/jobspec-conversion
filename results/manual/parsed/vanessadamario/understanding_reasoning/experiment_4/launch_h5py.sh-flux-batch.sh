#!/bin/bash
#FLUX: --job-name=evalEXP4
#FLUX: --queue=normal
#FLUX: --priority=16

module add openmind/singularity/3.4.1
singularity exec -B /om2:/om2 --nv path_to_singularity-tensorflow-latest-tqm.simg python3 \
path_to_folder/understanding_reasoning/experiment_4/main.py \
--host_filesystem om2_exp4 \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--on_validation True \
--run test
singularity exec -B /om2:/om2 --nv path_to_singularity-tensorflow-latest-tqm.simg python3 \
path_to_folder/understanding_reasoning/experiment_4/main.py \
--host_filesystem om2_exp4 \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--run test
singularity exec -B /om2:/om2 --nv path_to_singularity-tensorflow-latest-tqm.simg python3 \
path_to_folder/understanding_reasoning/experiment_4/main.py \
--host_filesystem om2_exp4 \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--test_seen True \
--run test
