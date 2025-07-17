#!/bin/bash
#FLUX: --job-name=ACT_half-sep_find
#FLUX: --queue=normal
#FLUX: -t=3600
#FLUX: --urgency=16

module add cluster/singularity/3.4.1
hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
singularity exec -B /om2:/om2 --nv path_singularity_tensorflow2.5.0 python3 main.py \
--host_filesystem om2 \
--experiment_index 0 --dataset_name dataset_15 --architecture_type half-sep_find \
--output_path path_to_folder/understanding_reasoning/experiment_1/results_AWS \
--new_output_path True \
--new_data_path True \
--experiment_case 1 \
--run activations
singularity exec -B /om2:/om2 --nv path_singularity_tensorflow2.5.0 python3 main.py \
--host_filesystem om2 \
--experiment_index 0 --dataset_name dataset_16 --architecture_type half-sep_find \
--output_path path_to_folder/understanding_reasoning/experiment_1/results_AWS \
--new_output_path True \
--new_data_path True \
--experiment_case 1 \
--run activations
singularity exec -B /om2:/om2 --nv path_singularity_tensorflow2.5.0 python3 main.py \
--host_filesystem om2 \
--experiment_index 0 --dataset_name dataset_17 --architecture_type half-sep_find \
--output_path path_to_folder/understanding_reasoning/experiment_1/results_AWS \
--new_output_path True \
--new_data_path True \
--experiment_case 1 \
--run activations
singularity exec -B /om2:/om2 --nv path_singularity_tensorflow2.5.0 python3 main.py \
--host_filesystem om2 \
--experiment_index 0 --dataset_name dataset_18 --architecture_type half-sep_find \
--output_path path_to_folder/understanding_reasoning/experiment_1/results_AWS \
--new_output_path True \
--new_data_path True \
--experiment_case 1 \
--run activations
singularity exec -B /om2:/om2 --nv path_singularity_tensorflow2.5.0 python3 main.py \
--host_filesystem om2 \
--experiment_index 0 --dataset_name dataset_26 --architecture_type half-sep_find \
--output_path path_to_folder/understanding_reasoning/experiment_1/results_AWS \
--new_output_path True \
--new_data_path True \
--experiment_case 1 \
--run activations
singularity exec -B /om2:/om2 --nv path_singularity_tensorflow2.5.0 python3 main.py \
--host_filesystem om2 \
--experiment_index 0 --dataset_name dataset_27 --architecture_type half-sep_find \
--output_path path_to_folder/understanding_reasoning/experiment_1/results_AWS \
--new_output_path True \
--new_data_path True \
--experiment_case 1 \
--run activations
