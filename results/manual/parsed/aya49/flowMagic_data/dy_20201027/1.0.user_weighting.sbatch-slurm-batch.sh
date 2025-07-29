#!/bin/bash
#SBATCH --output=./1.0.weighting_users/WEIGHTING_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

echo ${SLURM_ARRAY_TASK_ID}
singularity exec -B /mnt/f/Brinkman\ group/COVID/data/structure_test/:/data/ \
-B /mnt/f/Brinkman\ group/COVID/data/code/:/code/ \
/mnt/f/Docker/BrinkmanLabSingularity/python_test.im python \
/code/1.1.weighting_users_code_30June2020_v2.py ${SLURM_ARRAY_TASK_ID}
