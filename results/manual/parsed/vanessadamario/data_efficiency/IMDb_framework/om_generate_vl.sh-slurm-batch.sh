#!/bin/bash
#SBATCH --job-name=foveation
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem=40GB
#SBATCH --time=1-12:00:00
#SBATCH --qos=cbmm
#SBATCH --array=12-35

hostname
module add openmind/singularity/3.4.1
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow-vanessa.simg \
python /om/user/vanessad/IMDb_framework/main.py \
--host_filesystem om \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--offset_index 0 \
--run train \
--repetition_folder_path kim_init_weights
