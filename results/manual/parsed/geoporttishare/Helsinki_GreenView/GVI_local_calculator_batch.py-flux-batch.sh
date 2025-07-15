#!/bin/bash
#FLUX: --job-name=gassy-cat-1445
#FLUX: --priority=16

module purge
module load gcc/4.9.3
module load intelmpi/5.1.1
module load mkl/11.3.0
module load python/2.7.10
source /homeappl/home/username/venv_treepedia/bin/activate 
cd /wrk/username
srun python GreenView_local_calculator.py $SLURM_ARRAY_TASK_ID
