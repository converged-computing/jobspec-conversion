#!/bin/bash
#SBATCH --job-name=train_sqoop
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=26GB
#SBATCH --time=3-18:00:00
#SBATCH --constraint=8GB
#SBATCH --chdir=om2/user/vanessad/understanding_reasoning/experiment_4/slurm_output
#SBATCH --array=0
#SBATCH --exclude=node023,node026

module add openmind/singularity/3.4.1
hostname
echo $CUDA_VISIBLE_DEVICES
echo $CUDA_DEVICE_ORDER
singularity exec -B /om2:/om2 --nv om/user/xboix/singularity/xboix-tensorflow2.5.0.simg python3 \
/om2/user/vanessad/understanding_reasoning/experiment_4/main.py \
--host_filesystem om2_exp4 \
--offset_index 3600 \
--load_model True \
--output_folder spatial_only_second_trial \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--run train
