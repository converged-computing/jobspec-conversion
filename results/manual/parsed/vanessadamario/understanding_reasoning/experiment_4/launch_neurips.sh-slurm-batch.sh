#!/bin/bash
#SBATCH --job-name=groupall4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=3GB
#SBATCH --time=1-06:00:00
#SBATCH --partition=normal
#SBATCH --constraint=8GB
#SBATCH --chdir=/om2/user/vanessad/understanding_reasoning/experiment_4/slurm_output
#SBATCH --array=2-5,9-10
#SBATCH --exclude=node022,node023,node026,node021,node028,node094,node093

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
