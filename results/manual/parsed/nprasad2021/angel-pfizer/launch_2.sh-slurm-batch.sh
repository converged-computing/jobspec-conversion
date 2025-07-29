#!/bin/bash
#SBATCH --job-name=new_exp
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:titan-x:1
#SBATCH --mem-per-cpu=10GB
#SBATCH --time=03:00:00
#SBATCH --chdir=./subs/ensemble/
#SBATCH --array=0-2

PATH_ANGEL="/om/user/nprasad/angel-pfizer"
cd ..
singularity exec -B /om:/om --nv /om/user/nprasad/singularity/belledon-tensorflow-keras-master-latest.simg \
python /om/user/nprasad/angel-pfizer/main.py $PATH_ANGEL ${SLURM_ARRAY_TASK_ID}
