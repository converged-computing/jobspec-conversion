#!/bin/bash
#SBATCH --job-name=ACT_half-sep_find
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=30GB
#SBATCH --time=01:00:00
#SBATCH --partition=normal
#SBATCH --constraint=8GB,2G
#SBATCH --array=0
#SBATCH --exclude=node003,node023,node026,node022

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
