#!/bin/bash
#FLUX: --job-name=confused-bicycle-8861
#FLUX: -t=300
#FLUX: --urgency=16

singularity exec -B /mnt/f/Brinkman\ group/COVID/data/structure_test/:/data/ \
-B /mnt/f/Brinkman\ group/COVID/data/code/:/code/ \
-B /mnt/FCS_local3/COVID/:/mount/ \
/mnt/f/Docker/BrinkmanLabSingularity/brinkman_lab_singularity_190809_ompiv216_190908.im Rscript /code/3.1.post_processing_biaxial_generation.R ${SLURM_ARRAY_TASK_ID}
