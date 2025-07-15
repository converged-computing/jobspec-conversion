#!/bin/bash
#FLUX: --job-name=hanky-egg-8513
#FLUX: --priority=16

singularity exec -B /mnt/f:/data/ \
/mnt/f/Docker/BrinkmanLabSingularity/brinkman_lab_singularity_190418.im Rscript \
/data/Brinkman\ group/COVID/data/code/data_check.R ${SLURM_ARRAY_TASK_ID}
