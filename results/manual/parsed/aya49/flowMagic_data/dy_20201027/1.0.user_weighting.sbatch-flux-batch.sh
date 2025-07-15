#!/bin/bash
#FLUX: --job-name=goodbye-leader-0575
#FLUX: --priority=16

echo ${SLURM_ARRAY_TASK_ID}
singularity exec -B /mnt/f/Brinkman\ group/COVID/data/structure_test/:/data/ \
-B /mnt/f/Brinkman\ group/COVID/data/code/:/code/ \
/mnt/f/Docker/BrinkmanLabSingularity/python_test.im python \
/code/1.1.weighting_users_code_30June2020_v2.py ${SLURM_ARRAY_TASK_ID}
