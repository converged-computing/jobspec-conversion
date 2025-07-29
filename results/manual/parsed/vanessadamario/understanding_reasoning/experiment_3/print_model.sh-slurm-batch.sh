#!/bin/bash
#SBATCH --job-name=print
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=26GB
#SBATCH --time=00:30:00
#SBATCH --array=0

module add openmind/singularity/3.4.1
hostname
singularity exec -B /om2:/om2 --nv /om/user/xboix/singularity/xboix-tensorflow2.5.0.simg \
 python3 /om2/user/vanessad/understanding_reasoning/experiment_3/main.py \
 --host_filesystem om2 \
--output_path results_NeurIPS_revision \
--offset_index 0 \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--run print
