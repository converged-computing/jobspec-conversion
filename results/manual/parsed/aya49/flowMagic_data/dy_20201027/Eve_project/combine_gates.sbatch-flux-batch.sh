#!/bin/bash
#FLUX: --job-name=faux-bicycle-5086
#FLUX: --urgency=16

echo ${SLURM_ARRAY_TASK_ID}
singularity exec -B /mnt/f/Brinkman\ group/COVID/data/structure_test/:/data/ \
-B /mnt/f/Brinkman\ group/COVID/data/code/:/code/ \
-B /mnt/FCS_local3/COVID/:/mount/ \
/mnt/f/Docker/BrinkmanLabSingularity/python_test.im python /code/python_script_hybrid_25June2020.py ${SLURM_ARRAY_TASK_ID}
