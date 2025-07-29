#!/bin/bash
#SBATCH --job-name=get_activations
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem=8GB
#SBATCH --time=01:00:00
#SBATCH --partition=cbmm
#SBATCH --chdir=/om/user/scasper/workspace/
#SBATCH --array=4

cd /om/user/scasper/workspace/
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/get_activations.py ${SLURM_ARRAY_TASK_ID}
