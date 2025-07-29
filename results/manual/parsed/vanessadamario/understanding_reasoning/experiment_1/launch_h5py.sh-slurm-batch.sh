#!/bin/bash
#FLUX: --job-name=data10x
#FLUX: --queue=normal
#FLUX: -t=6000
#FLUX: --urgency=16

module add clustername/singularity/3.4.1
singularity exec -B /om2:/om2 --nv path_to_singularity python3 \
path_to_folder/understanding_reasoning/experiment_1/main.py \
--host_filesystem om2 \
--output_path path_to_folder/understanding_reasoning/experiment_1/10x_data/ \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--dataset_name dataset_31 \
--test_seen True \
--run convert
singularity exec -B /om2:/om2 --nv path_to_singularity python3 \
path_to_folder/understanding_reasoning/experiment_1/main.py \
--host_filesystem om2 \
--output_path path_to_folder/understanding_reasoning/experiment_1/10x_data/ \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--dataset_name dataset_32 \
--test_seen True \
--run convert
singularity exec -B /om2:/om2 --nv path_to_singularity python3 \
path_to_folder/understanding_reasoning/experiment_1/main.py \
--host_filesystem om2 \
--output_path path_to_folder/understanding_reasoning/experiment_1/10x_data/ \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--dataset_name dataset_33 \
--test_seen True \
--run convert
