#!/bin/bash
#SBATCH --output=./3.0.post_processing/POSTPROC_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

singularity exec -B /mnt/f/Brinkman\ group/COVID/data/structure_test/:/data/ \
-B /mnt/f/Brinkman\ group/COVID/data/code/:/code/ \
-B /mnt/FCS_local3/COVID/:/mount/ \
/mnt/f/Docker/BrinkmanLabSingularity/brinkman_lab_singularity_190809_ompiv216_190908.im Rscript /code/3.1.post_processing_biaxial_generation.R ${SLURM_ARRAY_TASK_ID}
