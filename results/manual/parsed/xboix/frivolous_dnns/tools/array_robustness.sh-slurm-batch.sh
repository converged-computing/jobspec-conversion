#!/bin/bash
#SBATCH --job-name=get_robustness
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem=12GB
#SBATCH --time=02:00:00
#SBATCH --chdir=/om/user/scasper/workspace/
#SBATCH --array=2-6

cd /om/user/scasper/workspace/
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow1.14.simg \
python /om/user/scasper/redundancy/get_robustness.py ${SLURM_ARRAY_TASK_ID}
